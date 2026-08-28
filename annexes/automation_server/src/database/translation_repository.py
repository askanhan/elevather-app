# Read/write helpers for the generic content_translation table and the
# read-only lookups needed to match a translation Excel file's rows back to
# already-imported module/simulator/card/component rows.
from .connection import execute_command


def upsert_translation(table_name, row_id, field_name, locale, value):
    """
    Insert or update one content_translation row. Returns False (no-op) when
    value is empty, so untranslated cells never overwrite a real override
    with blank text. Returns True once the write is attempted - regardless
    of whether MySQL took the insert or the "ON DUPLICATE KEY UPDATE" branch,
    since lastrowid is not a reliable insert-vs-update signal across drivers.
    """
    if value is None:
        return False
    value = str(value).strip()
    if not value:
        return False

    sql = (
        "INSERT INTO content_translation (table_name, row_id, field_name, locale, value) "
        "VALUES (%s, %s, %s, %s, %s) "
        "ON DUPLICATE KEY UPDATE value = VALUES(value)"
    )
    execute_command(sql, (table_name, row_id, field_name, locale, value), is_insert=True)
    return True


def get_module_id_by_day(day_number):
    res = execute_command("SELECT id FROM module WHERE day_number = %s", (day_number,))
    return res[0]['id'] if res else None


def get_simulator_id_by_title(title):
    res = execute_command("SELECT id FROM simulator WHERE title = %s", (title,))
    return res[0]['id'] if res else None


def get_cards(owner_type, owner_id):
    return execute_command(
        "SELECT id, card_order_index FROM card WHERE owner_type = %s AND owner_id = %s ORDER BY card_order_index",
        (owner_type, owner_id)
    ) or []


def get_card_contains(card_id):
    return execute_command(
        "SELECT component_type, component_order_index, component_id FROM card_contains "
        "WHERE card_id = %s ORDER BY component_order_index",
        (card_id,)
    ) or []


def get_mcq_options(mcq_id):
    return execute_command(
        "SELECT id, option_text, feedback FROM multiple_choices_options WHERE mcq_id = %s ORDER BY id",
        (mcq_id,)
    ) or []


def get_feedback_tiers(simulator_id):
    return execute_command(
        "SELECT id, metric_id, min_score, max_score FROM simulator_feedback_tiers "
        "WHERE simulator_id = %s ORDER BY id",
        (simulator_id,)
    ) or []
