# Audits how complete a locale's coverage of content_translation actually is.
#
# translation_importer.py only writes rows for what it could safely match; a
# card whose translation file has a different component layout gets skipped
# entirely (logged as a WARNING at import time, but easy to lose track of
# afterwards). This module re-derives, straight from the database, the full
# set of (table, row_id, field_name) that *should* have a translation - every
# non-empty translatable field reachable from every module/simulator - and
# diffs it against what's actually in content_translation, so nothing found
# by the importer's warnings (or missed some other way) stays invisible.
import csv
import os

from .connection import execute_command

# Same shape as translation_importer.TRANSLATABLE_FIELDS - kept separate
# because this module reasons about ALL rows of each table, not just ones
# reached while walking a specific Excel file.
COMPONENT_TRANSLATABLE_FIELDS = {
    'component_title': ['content'],
    'component_subtitle': ['content'],
    'component_text': ['content'],
    'component_quote': ['content'],
    'component_image': ['image_alt', 'image_description'],
    'component_video': ['video_alt', 'video_description'],
    'component_mcq': ['question'],
    'component_open_questions': ['question'],
    'component_list': ['content'],
    'component_last_messages': ['content'],
}

CARD_FIELDS = ['title', 'subtitle', 'end_text', 'why_this_question']
MODULE_FIELDS = ['title', 'description', 'target_audience']
SIMULATOR_FIELDS = ['title', 'description']
TIER_FIELDS = ['strength_result', 'risk_result', 'micro_practice', 'recommendation_reason']


def _existing_translations(locale):
    """Returns the set of (table_name, row_id, field_name) already translated for locale."""
    rows = execute_command(
        "SELECT table_name, row_id, field_name FROM content_translation WHERE locale = %s",
        (locale,)
    ) or []
    return {(r['table_name'], r['row_id'], r['field_name']) for r in rows}


def _card_context():
    """
    Maps card_id -> a human-readable label ("Module 'X' (day N), card 3" or
    "Simulator 'Y', card 2") so missing fields can be reported without making
    the reader cross-reference ids by hand.
    """
    modules = {m['id']: m for m in execute_command("SELECT id, day_number, title FROM module") or []}
    simulators = {s['id']: s for s in execute_command("SELECT id, title FROM simulator") or []}

    context = {}
    for card in execute_command("SELECT id, owner_type, owner_id, card_order_index FROM card") or []:
        if card['owner_type'] == 'module' and card['owner_id'] in modules:
            m = modules[card['owner_id']]
            label = f"Module '{m['title']}' (day {m['day_number']}), card {card['card_order_index']}"
        elif card['owner_type'] == 'simulator' and card['owner_id'] in simulators:
            s = simulators[card['owner_id']]
            label = f"Simulator '{s['title']}', card {card['card_order_index']}"
        else:
            label = f"{card['owner_type']} {card['owner_id']}, card {card['card_order_index']}"
        context[card['id']] = label
    return context, modules, simulators


def find_missing_translations(locale):
    """
    Returns a list of dicts, one per translatable field that has real
    (non-empty) base content but no content_translation row for `locale`:
    {location, table_name, row_id, field_name, base_value_preview}
    """
    existing = _existing_translations(locale)
    card_context, modules, simulators = _card_context()
    missing = []

    def check(table_name, row_id, field_name, value, location):
        if value is None or str(value).strip() == '':
            return  # nothing to translate here regardless of locale
        if (table_name, row_id, field_name) in existing:
            return
        preview = str(value).strip().replace('\n', ' ')[:60]
        missing.append({
            'location': location,
            'table_name': table_name,
            'row_id': row_id,
            'field_name': field_name,
            'base_value_preview': preview,
        })

    # Modules
    for m in modules.values():
        location = f"Module '{m['title']}' (day {m['day_number']})"
        full = execute_command("SELECT * FROM module WHERE id = %s", (m['id'],))[0]
        for field_name in MODULE_FIELDS:
            check('module', m['id'], field_name, full.get(field_name), location)

    # Simulators
    for s in simulators.values():
        location = f"Simulator '{s['title']}'"
        full = execute_command("SELECT * FROM simulator WHERE id = %s", (s['id'],))[0]
        for field_name in SIMULATOR_FIELDS:
            check('simulator', s['id'], field_name, full.get(field_name), location)

    # Cards
    for card in execute_command("SELECT * FROM card") or []:
        location = card_context.get(card['id'], f"card {card['id']}")
        for field_name in CARD_FIELDS:
            check('card', card['id'], field_name, card.get(field_name), location)

    # Components, one query per table (so it stays O(#tables) not O(#components))
    for table_name, field_names in COMPONENT_TRANSLATABLE_FIELDS.items():
        rows = execute_command(f"SELECT * FROM {table_name}") or []
        # component_id -> card location, resolved through card_contains
        links = execute_command(
            "SELECT cc.card_id, cc.component_id FROM card_contains cc WHERE cc.component_type = %s",
            (_type_enum_for_table(table_name),)
        ) or []
        location_by_component_id = {l['component_id']: card_context.get(l['card_id'], f"card {l['card_id']}") for l in links}

        for row in rows:
            location = location_by_component_id.get(row['id'], f"{table_name} {row['id']} (not linked to any card)")
            for field_name in field_names:
                check(table_name, row['id'], field_name, row.get(field_name), location)

    # MCQ options
    mcq_links = execute_command(
        "SELECT cc.card_id, cc.component_id FROM card_contains cc WHERE cc.component_type = 'mcq'"
    ) or []
    location_by_mcq_id = {l['component_id']: card_context.get(l['card_id'], f"card {l['card_id']}") for l in mcq_links}
    for option in execute_command("SELECT * FROM multiple_choices_options") or []:
        location = location_by_mcq_id.get(option['mcq_id'], f"MCQ {option['mcq_id']} (not linked to any card)")
        check('multiple_choices_options', option['id'], 'option_text', option.get('option_text'), location)
        check('multiple_choices_options', option['id'], 'feedback', option.get('feedback'), location)

    # Simulator metrics (name) and feedback tiers - reported separately since
    # simulator_feedback_tiers has a known pre-existing duplicate-row issue
    # (see repository.clear_content_only_data) independent of translations.
    for metric in execute_command("SELECT * FROM simulator_metric") or []:
        check('simulator_metric', metric['id'], 'name', metric.get('name'), f"Metric '{metric.get('name')}'")

    for tier in execute_command("SELECT * FROM simulator_feedback_tiers") or []:
        sim = simulators.get(tier['simulator_id'])
        location = f"Simulator '{sim['title']}' feedback tier {tier['id']} (metric {tier['metric_id']})" if sim else f"feedback tier {tier['id']}"
        for field_name in TIER_FIELDS:
            check('simulator_feedback_tiers', tier['id'], field_name, tier.get(field_name), location)

    return missing


def _type_enum_for_table(table_name):
    return {
        'component_title': 'title',
        'component_subtitle': 'subtitle',
        'component_text': 'text',
        'component_quote': 'quote',
        'component_image': 'image',
        'component_video': 'video',
        'component_mcq': 'mcq',
        'component_open_questions': 'open question',
        'component_list': 'list',
        'component_last_messages': 'last message',
    }[table_name]


def print_coverage_report(locale):
    missing = find_missing_translations(locale)

    if not missing:
        print(f"\nNo missing translations found for locale '{locale}' - full coverage!")
        return missing

    by_location = {}
    for item in missing:
        by_location.setdefault(item['location'], []).append(item)

    print(f"\n{'='*60}")
    print(f"MISSING TRANSLATIONS FOR LOCALE '{locale}': {len(missing)} field(s) across {len(by_location)} location(s)")
    print(f"{'='*60}")
    for location, items in by_location.items():
        print(f"\n{location}")
        for item in items:
            print(f"   - {item['table_name']}.{item['field_name']} (id={item['row_id']}): \"{item['base_value_preview']}\"")

    return missing


def save_coverage_csv(locale, missing, output_path=None):
    if output_path is None:
        current_dir = os.path.dirname(os.path.abspath(__file__))
        output_dir = os.path.abspath(os.path.join(current_dir, "../../generated_sql"))
        os.makedirs(output_dir, exist_ok=True)
        output_path = os.path.join(output_dir, f"missing_translations_{locale}.csv")

    with open(output_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=['location', 'table_name', 'row_id', 'field_name', 'base_value_preview'])
        writer.writeheader()
        writer.writerows(missing)

    print(f"\nFull list saved to: {output_path}")
    return output_path
