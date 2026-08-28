# One-off audit: compares every module's DB card_contains composition
# against its original English source Excel file, per card, ignoring order
# (translation_importer's type-grouped matcher already tolerates reordering).
# Anything where DB's component-type multiset differs from the source's is a
# genuine base-content gap (like the list-truncation bug); anything where DB
# matches the source exactly is, by definition, not a database bug - any
# remaining translation mismatch there is on the translation file's side.
from collections import Counter

from .connection import execute_command
from .content_repair import resolve_day_to_file
from .translation_importer import _course_component_units
from ..utils.excel_loader import load_data, extract_full_card_data


def audit_all_modules():
    by_day = resolve_day_to_file()
    findings = []

    for day_number, file_info in sorted(by_day.items()):
        module_row = execute_command("SELECT id, title FROM module WHERE day_number = %s", (day_number,))
        if not module_row:
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
        for sheet_name, df_sheet in course_df.items():
            if "Card" not in sheet_name:
                continue
            _, components = extract_full_card_data(df_sheet, card_count)
            units = _course_component_units(components)

            db_card = next((c for c in existing_cards if c['card_order_index'] == card_count), None)
            if db_card:
                links = execute_command(
                    "SELECT component_type FROM card_contains WHERE card_id = %s", (db_card['id'],)
                ) or []
                en_composition = Counter('list' if u['kind'] == 'list_item' else u.get('type_enum') for u in units)
                db_composition = Counter(l['component_type'] for l in links)
                if en_composition != db_composition:
                    findings.append({
                        'day': day_number, 'title': module_title, 'card': card_count,
                        'card_id': db_card['id'],
                        'en': dict(en_composition), 'db': dict(db_composition),
                    })
            card_count += 1

    return findings
