# Imports translated Excel files under data-sources/translations/<locale>/{days,simulators}
# into the content_translation table, by re-parsing them with the same
# excel_loader functions used for the original import and matching the
# resulting rows back to already-imported module/simulator/card/component
# rows - positionally, since a translation file is a cell-for-cell copy of
# the original template (same sheets, same rows, same columns; only the
# user-facing text differs).
import os
import re

from .translation_repository import (
    upsert_translation, get_module_id_by_day, get_simulator_id_by_title,
    get_cards, get_card_contains, get_mcq_options, get_feedback_tiers
)
from ..utils.excel_loader import (
    load_data, map_excel_to_db, extract_full_card_data, extract_simulator_cards,
    clean_content
)
from ..utils.excel_mapping import (
    MODULE_TABLE_MAP, SIMULATOR_TABLE_MAP, SIMULATOR_TRANSLATION_TITLE_MAP, COURSE_TRANSLATION_DAY_OVERRIDES,
    CZECH_SIMULATOR_OVERVIEW_HEADER_MAP, CZECH_SIMULATOR_CARDS_HEADER_MAP, CZECH_SIMULATOR_METRIC_WRITING_HEADER_MAP,
    CZECH_COURSE_OVERVIEW_HEADER_MAP
)
from ..utils.sql_generator import find_overview_sheet, find_overview_row

DAY_NUMBER_RE = re.compile(r'^(\d+)')


# Explicit allow-list, not a blind "strip trailing 2 letters" regex - several
# original filenames legitimately end in a 2-letter chunk of their own (e.g.
# "...Course06_AI.xlsx"), which a blind pattern would misfire on.
_KNOWN_LOCALE_SUFFIXES = ('NL', 'PL', 'CZ', 'GR', 'DE', 'EN', 'FR', 'TR', 'CS', 'EL')
_LOCALE_SUFFIX_RE = re.compile(r'_?(' + '|'.join(_KNOWN_LOCALE_SUFFIXES) + r')$', re.IGNORECASE)


def _normalize_filename(filename):
    stem = os.path.splitext(filename)[0]
    stem = _LOCALE_SUFFIX_RE.sub('', stem)
    return re.sub(r'[^a-z0-9]', '', stem.lower())


def resolve_day_number(filename):
    """
    Some translation folders name files with a leading day number (the "pl"
    folder); others just reuse the original filename with a locale suffix
    appended (the "be"/nl folder, e.g. "VisionTree_Course06_AI_NL.xlsx"
    against the original "VisionTree_Course06_AI.xlsx"); one (cz) turned out
    to have some files whose own leading number is simply wrong for the
    content inside, verified by hand - see COURSE_TRANSLATION_DAY_OVERRIDES.
    Checked in that order: explicit override first, then the normalized-name
    match (a leading digit in a reused-name file like the "1_AVITEUM_..."
    ones is just part of that country's filename convention, not a day
    number, so it's more reliable than the regex), then the regex as a
    last resort.
    """
    if filename in COURSE_TRANSLATION_DAY_OVERRIDES:
        return COURSE_TRANSLATION_DAY_OVERRIDES[filename]

    from .content_repair import resolve_day_to_file  # local import: avoids a circular import at module load time
    by_day = resolve_day_number._cache
    if by_day is None:
        by_day = {_normalize_filename(f['filename']): day for day, f in resolve_day_to_file().items()}
        resolve_day_number._cache = by_day

    matched = by_day.get(_normalize_filename(filename))
    if matched is not None:
        return matched

    match = DAY_NUMBER_RE.match(filename)
    return int(match.group(1)) if match else None


resolve_day_number._cache = None


def _find_sheet_by_alias(df_dict, aliases):
    """
    Some cz/ translation files translate every sheet name, not just cell
    content (e.g. "Cards" -> "Karty", "Metric Writing" -> "Texty k metrikám"),
    so an exact-name lookup misses them. Falls back to a case-insensitive
    substring match against known aliases for that sheet's role.
    """
    for name, df in df_dict.items():
        lname = name.lower()
        if any(alias in lname for alias in aliases):
            return df
    return None


def normalize_czech_headers(excel_df):
    """
    A few cz/ translation files translate every column header too, not just
    sheet names and cell content, which breaks the English-header-driven
    parsing (map_excel_to_db, extract_simulator_cards, etc.) downstream.
    Renames columns back to English wherever a sheet's columns match one of
    the known Czech header sets - a no-op for every other file, where none
    of these Czech names are present to match.
    """
    header_maps = (
        CZECH_SIMULATOR_OVERVIEW_HEADER_MAP,
        CZECH_SIMULATOR_CARDS_HEADER_MAP,
        CZECH_SIMULATOR_METRIC_WRITING_HEADER_MAP,
        CZECH_COURSE_OVERVIEW_HEADER_MAP,
    )
    renamed = {}
    for sheet_name, df in excel_df.items():
        # Some maps share a key (e.g. "Odhadovaná délka (minuty)" appears in
        # both the simulator- and course-overview maps), so the first map
        # with *any* overlap isn't necessarily the right one - pick whichever
        # map matches the most of this sheet's columns instead.
        best_map, best_score = None, 0
        for header_map in header_maps:
            score = sum(1 for col in header_map if col in df.columns)
            if score > best_score:
                best_map, best_score = header_map, score
        if best_map:
            df = df.rename(columns=best_map)
        renamed[sheet_name] = df
    return renamed


def _is_card_sheet(sheet_name):
    """"Card" in most templates; "Karta" in a Czech-named one."""
    lname = sheet_name.lower()
    return 'card' in lname or 'karta' in lname

# Which fields of each component table are actual user-facing text - mirrors
# exactly what api/services/translations.py reads back on the Django side.
TRANSLATABLE_FIELDS = {
    'component_title': ['content'],
    'component_subtitle': ['content'],
    'component_text': ['content'],
    'component_quote': ['content'],
    'component_image': ['image_alt', 'image_description'],
    'component_video': ['video_alt', 'video_description'],
    'component_open_questions': ['question'],
    'component_last_messages': ['content'],
}


def _translations_root():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    return os.path.abspath(os.path.join(current_dir, "../../data-sources/translations"))


def discover_translation_files(locale, kind, folder_name=None):
    """
    kind: 'days' or 'simulators'.
    folder_name: the data-sources/translations/<folder_name> directory to read
    from, if it differs from the locale code stored alongside the content
    (e.g. the "be" folder holds Dutch/"nl" translations). Defaults to locale.
    Returns a list of {'filename', 'full_path'} dicts.
    """
    folder = os.path.join(_translations_root(), folder_name or locale, kind)
    if not os.path.exists(folder):
        print(f"WARNING: Translation folder not found: {folder}")
        return []

    files = []
    for name in sorted(os.listdir(folder)):
        if name.endswith(('.xlsx', '.xlsm')) and not name.startswith('~'):
            files.append({'filename': name, 'full_path': os.path.join(folder, name)})
    return files


def _course_component_units(components):
    """
    Reproduce, in order, the same sequence of "translated units" that
    importer.import_course() turned into card_contains rows, so it can be
    zipped positionally against the DB's existing card_contains rows for
    that card. Mirrors the skip/expansion rules in import_course() exactly.
    """
    units = []
    for comp in components:
        if comp['content'] is None and comp['table'] != 'component_list':
            continue

        if comp['table'] == 'component_mcq':
            units.append({'kind': 'mcq', 'type_enum': 'mcq', 'question': comp['content'], 'options': comp.get('options', [])})
        elif comp['table'] == 'component_list':
            values = []
            if comp['content']:
                values.append(comp['content'])
            values.extend(item for item in comp.get('list_items', []) if item)
            for value in values:
                units.append({'kind': 'list_item', 'value': value})
        else:
            fields = dict(comp.get('fields', {}))
            fields[comp['column']] = comp['content']
            units.append({'kind': 'simple', 'table': comp['table'], 'type_enum': comp['type_enum'], 'fields': fields})
    return units


def _simulator_component_units(components):
    """
    Same idea as _course_component_units() but mirroring
    importer.import_simulator()'s card loop instead.
    """
    units = []
    for comp in components:
        if comp.get('content') is None:
            continue

        if comp['type'] == 'mcq':
            units.append({'kind': 'mcq', 'type_enum': 'mcq', 'question': comp['content'], 'options': comp['options']})
        else:
            table = comp.get('table', 'component_text')
            column = comp.get('column', 'content')
            fields = dict(comp.get('fields', {}))
            fields[column] = comp['content']
            units.append({'kind': 'simple', 'table': table, 'type_enum': comp['type'], 'fields': fields})
    return units


def _apply_simple_unit(unit, link, locale, stats):
    for field_name in TRANSLATABLE_FIELDS.get(unit['table'], []):
        if upsert_translation(unit['table'], link['component_id'], field_name, locale, unit['fields'].get(field_name)):
            stats['fields'] += 1


def _apply_mcq_unit(unit, link, locale, stats):
    if upsert_translation('component_mcq', link['component_id'], 'question', locale, unit['question']):
        stats['fields'] += 1

    options = get_mcq_options(link['component_id'])
    translated_options = unit['options']
    if len(options) != len(translated_options):
        print(f"      WARNING: MCQ {link['component_id']} option count mismatch "
              f"(db={len(options)}, translation={len(translated_options)}) - skipping its options")
        return

    for option, translated in zip(options, translated_options):
        text = translated.get('text') if isinstance(translated, dict) else translated
        feedback = translated.get('feedback') if isinstance(translated, dict) else None
        if upsert_translation('multiple_choices_options', option['id'], 'option_text', locale, text):
            stats['fields'] += 1
        if feedback and upsert_translation('multiple_choices_options', option['id'], 'feedback', locale, feedback):
            stats['fields'] += 1


def _apply_list_unit(unit, link, locale, stats):
    if upsert_translation('component_list', link['component_id'], 'content', locale, unit['value']):
        stats['fields'] += 1


def _type_key(unit_or_link):
    """Normalizes a unit's or a card_contains link's type into a common key."""
    if isinstance(unit_or_link, dict) and 'component_type' in unit_or_link:
        return unit_or_link['component_type']
    return 'list' if unit_or_link['kind'] == 'list_item' else unit_or_link.get('type_enum')


def _apply_units_to_card(units, links, locale, stats):
    """
    Match translated components to the card's existing card_contains links.
    Translators sometimes reorder rows within a card sheet (e.g. move an
    image above the title) without changing which components exist, so
    matching is done within each component-type group (in that group's own
    relative order) rather than across the whole card's raw sequence.

    Matching (and translating) is done per type-group independently: a
    translator adding an extra list item or swapping an image for a video in
    one spot shouldn't block the title/text/mcq/etc. elsewhere in the same
    card, which line up just fine, from getting translated too.
    """
    units_by_type = {}
    for unit in units:
        units_by_type.setdefault(_type_key(unit), []).append(unit)

    links_by_type = {}
    for link in links:
        links_by_type.setdefault(_type_key(link), []).append(link)

    for type_key, type_units in units_by_type.items():
        type_links = links_by_type.get(type_key, [])
        if len(type_units) != len(type_links):
            print(f"      SKIP '{type_key}' component(s) in this card: "
                  f"db has {len(type_links)}, translation has {len(type_units)}")
            continue

        for unit, link in zip(type_units, type_links):
            if unit['kind'] == 'simple':
                _apply_simple_unit(unit, link, locale, stats)
            elif unit['kind'] == 'mcq':
                _apply_mcq_unit(unit, link, locale, stats)
            else:
                _apply_list_unit(unit, link, locale, stats)


def import_course_translation(file_info, locale):
    filename = file_info['filename']
    day_number = resolve_day_number(filename)
    if day_number is None:
        print(f"   SKIP: could not resolve a day number for '{filename}'")
        return False

    module_id = get_module_id_by_day(day_number)
    if not module_id:
        print(f"   SKIP: no module found with day_number={day_number} for '{filename}'")
        return False

    course_df = load_data(full_path=file_info['full_path'])
    if not course_df:
        return False
    course_df = normalize_czech_headers(course_df)

    try:
        _, overview_df = find_overview_sheet(course_df, sheet_type="course")
        overview_row = find_overview_row(overview_df, sheet_type="course")
    except ValueError as e:
        print(f"   SKIP: {e}")
        return False

    module_data = map_excel_to_db(overview_row, MODULE_TABLE_MAP)
    stats = {'fields': 0}
    for field_name in ('title', 'description', 'target_audience'):
        if upsert_translation('module', module_id, field_name, locale, module_data.get(field_name)):
            stats['fields'] += 1

    existing_cards = get_cards('module', module_id)

    card_count = 1
    for sheet_name, df_sheet in course_df.items():
        if not _is_card_sheet(sheet_name):
            continue

        card_attr, components = extract_full_card_data(df_sheet, card_count)

        db_card = next((c for c in existing_cards if c['card_order_index'] == card_count), None)
        if not db_card:
            print(f"   WARNING: no existing card at position {card_count} for module {module_id} - skipping")
            card_count += 1
            continue

        for field_name in ('title', 'subtitle', 'end_text', 'why_this_question'):
            if upsert_translation('card', db_card['id'], field_name, locale, card_attr.get(field_name)):
                stats['fields'] += 1

        units = _course_component_units(components)
        links = get_card_contains(db_card['id'])
        _apply_units_to_card(units, links, locale, stats)

        card_count += 1

    print(f"   OK: {stats['fields']} translated field(s) written for module {module_id} (day {day_number})")
    return True


def import_simulator_translation(file_info, locale):
    filename = file_info['filename']
    title = SIMULATOR_TRANSLATION_TITLE_MAP.get(filename)
    if not title:
        print(f"   SKIP: '{filename}' is not in SIMULATOR_TRANSLATION_TITLE_MAP - add it there first")
        return False

    simulator_id = get_simulator_id_by_title(title)
    if not simulator_id:
        print(f"   SKIP: no simulator found with title '{title}'")
        return False

    sim_df = load_data(full_path=file_info['full_path'])
    if not sim_df:
        return False
    sim_df = normalize_czech_headers(sim_df)

    try:
        _, overview_df = find_overview_sheet(sim_df, sheet_type="simulator")
        overview_row = find_overview_row(overview_df, sheet_type="simulator")
    except ValueError as e:
        print(f"   SKIP: {e}")
        return False

    sim_data = map_excel_to_db(overview_row, SIMULATOR_TABLE_MAP)
    stats = {'fields': 0}
    if upsert_translation('simulator', simulator_id, 'title', locale, sim_data.get('title')):
        stats['fields'] += 1
    if upsert_translation('simulator', simulator_id, 'description', locale, clean_content(overview_row.get('Description'))):
        stats['fields'] += 1

    existing_cards = get_cards('simulator', simulator_id)
    cards_sheet = sim_df.get("Cards")
    if cards_sheet is None:
        cards_sheet = _find_sheet_by_alias(sim_df, ('cards', 'karty'))

    if cards_sheet is not None:
        for card_data in extract_simulator_cards(cards_sheet):
            card_info = card_data['info']
            order = card_info['card_order_index']

            db_card = next((c for c in existing_cards if c['card_order_index'] == order), None)
            if not db_card:
                print(f"   WARNING: no existing card at order {order} for simulator {simulator_id} - skipping")
                continue

            for field_name in ('title', 'subtitle', 'end_text', 'why_this_question'):
                if upsert_translation('card', db_card['id'], field_name, locale, card_info.get(field_name)):
                    stats['fields'] += 1

            units = _simulator_component_units(card_data['components'])
            links = get_card_contains(db_card['id'])
            _apply_units_to_card(units, links, locale, stats)

    feedback_sheet = sim_df.get("Metric Writing")
    if feedback_sheet is None:
        feedback_sheet = _find_sheet_by_alias(sim_df, ('metric writing', 'texty k metrik'))
    if feedback_sheet is not None:
        existing_tiers = get_feedback_tiers(simulator_id)
        rows = list(feedback_sheet.iterrows())

        if len(rows) != len(existing_tiers):
            print(f"   WARNING: feedback tier count mismatch (db={len(existing_tiers)}, "
                  f"translation={len(rows)}) - skipping feedback tier translations")
        else:
            seen_metrics = set()
            for tier, (_, row) in zip(existing_tiers, rows):
                metric_name = clean_content(row.get('Metric Name'))
                if metric_name and tier['metric_id'] not in seen_metrics:
                    seen_metrics.add(tier['metric_id'])
                    if upsert_translation('simulator_metric', tier['metric_id'], 'name', locale, metric_name):
                        stats['fields'] += 1

                for field_name, excel_col in (
                    ('strength_result', 'Strength Text'),
                    ('risk_result', 'Risk Text'),
                    ('micro_practice', 'Suggested Micro-Practice'),
                    ('recommendation_reason', 'Recommendation Reason'),
                ):
                    if upsert_translation('simulator_feedback_tiers', tier['id'], field_name, locale, clean_content(row.get(excel_col))):
                        stats['fields'] += 1

    print(f"   OK: {stats['fields']} translated field(s) written for simulator {simulator_id} ('{title}')")
    return True


def import_all_course_translations(locale, folder_name=None):
    files = discover_translation_files(locale, 'days', folder_name=folder_name)
    print(f"\nFound {len(files)} course translation file(s) for locale '{locale}'"
          + (f" (folder '{folder_name}')" if folder_name else ""))
    success = 0
    for file_info in files:
        print(f"\n--- {file_info['filename']} ---")
        if import_course_translation(file_info, locale):
            success += 1
    return success


def import_all_simulator_translations(locale, folder_name=None):
    files = discover_translation_files(locale, 'simulators', folder_name=folder_name)
    print(f"\nFound {len(files)} simulator translation file(s) for locale '{locale}'"
          + (f" (folder '{folder_name}')" if folder_name else ""))
    success = 0
    for file_info in files:
        print(f"\n--- {file_info['filename']} ---")
        if import_simulator_translation(file_info, locale):
            success += 1
    return success
