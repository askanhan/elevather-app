# One-off repair for base (English) content that got truncated at original
# import time - specifically component_list runs where only the intro item
# made it into the database and the rest of that List field's items never
# did (see translation_coverage findings). Fixed by re-parsing each module's
# original source Excel with the current (already-correct) excel_loader
# functions and inserting whatever is missing, purely additively: existing
# rows/ids are never touched, only new component_list rows + card_contains
# links get appended, with later components' order indices shifted to make
# room.
from .connection import execute_command
from .translation_importer import _course_component_units
from ..utils.excel_loader import load_data, map_excel_to_db, safe_int
from ..utils.excel_mapping import MODULE_TABLE_MAP, DAY_NUMBER_OVERRIDES, TITLE_OVERRIDES
from ..utils.file_discovery import discover_excel_files
from ..utils.sql_generator import find_overview_sheet, find_overview_row


def resolve_day_to_file():
    """Same day-number resolution import_course() uses, returning {day_number: file_info}."""
    by_day = {}
    for file_info in discover_excel_files('course'):
        course_df = load_data(full_path=file_info['full_path'])
        if not course_df:
            continue
        try:
            _, overview_df = find_overview_sheet(course_df, sheet_type="course")
            overview_row = find_overview_row(overview_df, sheet_type="course")
        except ValueError:
            continue
        module_data = map_excel_to_db(overview_row, MODULE_TABLE_MAP)
        title = TITLE_OVERRIDES.get(file_info['filename'], module_data['title'])
        day_number = DAY_NUMBER_OVERRIDES.get(title, safe_int(module_data.get('day_number')))
        if day_number:
            by_day[day_number] = file_info
    return by_day


def _list_runs(links, list_contents):
    """
    Splits an ordered list of card_contains link dicts into runs of
    consecutive component_type == 'list' entries. Returns a list of dicts:
    {start_index, links, values} where `values` are that run's existing
    component_list.content strings, in order.
    """
    runs = []
    current = None
    for i, link in enumerate(links):
        if link['component_type'] == 'list':
            if current is None:
                current = {'start_index': i, 'links': []}
                runs.append(current)
            current['links'].append(link)
        else:
            current = None
    for run in runs:
        run['values'] = [list_contents.get(l['component_id'], '') for l in run['links']]
    return runs


def _expected_list_groups(units):
    """Same idea as _list_runs() but over the freshly-parsed source units."""
    groups = []
    current = None
    for unit in units:
        if unit['kind'] == 'list_item':
            if current is None:
                current = []
                groups.append(current)
            current.append(unit['value'])
        else:
            current = None
    return groups


def _normalize(text):
    return ' '.join(str(text or '').split()).strip().lower()


def repair_card_list_items(card_id, units, dry_run=True):
    """
    Compares one card's freshly-parsed source `units` against its existing
    card_contains rows and, for every list run whose current items are an
    exact prefix of what the source defines, appends the missing tail items.
    Returns a list of log strings describing what was found/done.
    """
    log = []
    links = execute_command(
        "SELECT id, component_type, component_order_index, component_id FROM card_contains "
        "WHERE card_id = %s ORDER BY component_order_index",
        (card_id,)
    ) or []

    list_component_ids = [l['component_id'] for l in links if l['component_type'] == 'list']
    list_contents = {}
    if list_component_ids:
        placeholders = ','.join(['%s'] * len(list_component_ids))
        rows = execute_command(
            f"SELECT id, content FROM component_list WHERE id IN ({placeholders})",
            tuple(list_component_ids)
        ) or []
        list_contents = {r['id']: r['content'] for r in rows}

    db_runs = _list_runs(links, list_contents)
    expected_groups = _expected_list_groups(units)

    if len(db_runs) != len(expected_groups):
        log.append(f"      SKIP card {card_id}: {len(db_runs)} list run(s) in DB vs "
                    f"{len(expected_groups)} in source - not a simple truncation, needs a manual look")
        return log

    # Apply from the last run to the first so order-index shifts never disturb
    # a run still waiting to be processed.
    for run, expected in list(zip(db_runs, expected_groups))[::-1]:
        existing_norm = [_normalize(v) for v in run['values']]
        expected_norm = [_normalize(v) for v in expected]

        if existing_norm == expected_norm:
            continue  # already complete

        if existing_norm != expected_norm[:len(existing_norm)]:
            log.append(f"      SKIP card {card_id} list run at position {run['start_index']}: "
                        f"existing items aren't a prefix of the source's - needs a manual look\n"
                        f"         existing: {run['values']}\n"
                        f"         source:   {expected}")
            continue

        missing = expected[len(existing_norm):]
        if not missing:
            continue

        last_link = run['links'][-1]
        insertion_order_index = last_link['component_order_index']
        log.append(f"      card {card_id}: adding {len(missing)} missing list item(s) after "
                    f"order_index {insertion_order_index}: {missing}")

        if dry_run:
            continue

        # Make room: shift every later component's order_index up by len(missing)
        execute_command(
            "UPDATE card_contains SET component_order_index = component_order_index + %s "
            "WHERE card_id = %s AND component_order_index > %s",
            (len(missing), card_id, insertion_order_index)
        )

        for offset, item_text in enumerate(missing, start=1):
            new_id = execute_command(
                "INSERT INTO component_list (content) VALUES (%s)", (item_text,), is_insert=True
            )
            execute_command(
                "INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) "
                "VALUES (%s, 'list', %s, %s)",
                (card_id, insertion_order_index + offset, new_id), is_insert=True
            )

    return log


def repair_all_course_list_items(dry_run=True):
    by_day = resolve_day_to_file()
    all_log = []

    for day_number, file_info in sorted(by_day.items()):
        module_row = execute_command("SELECT id, title FROM module WHERE day_number = %s", (day_number,))
        if not module_row:
            all_log.append(f"SKIP day {day_number}: no module in DB")
            continue
        module_id = module_row[0]['id']
        module_title = module_row[0]['title']

        course_df = load_data(full_path=file_info['full_path'])
        if not course_df:
            continue

        existing_cards = execute_command(
            "SELECT id, card_order_index FROM card WHERE owner_type = 'module' AND owner_id = %s "
            "ORDER BY card_order_index",
            (module_id,)
        ) or []

        card_count = 1
        card_logs = []
        for sheet_name, df_sheet in course_df.items():
            if "Card" not in sheet_name:
                continue
            from ..utils.excel_loader import extract_full_card_data
            _, components = extract_full_card_data(df_sheet, card_count)
            units = _course_component_units(components)

            db_card = next((c for c in existing_cards if c['card_order_index'] == card_count), None)
            if db_card:
                card_logs.extend(repair_card_list_items(db_card['id'], units, dry_run=dry_run))
            card_count += 1

        if card_logs:
            all_log.append(f"Day {day_number} - '{module_title}' ({file_info['filename']})")
            all_log.extend(card_logs)

    return all_log
