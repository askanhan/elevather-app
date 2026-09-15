#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Translation-table equivalent of cleanup_duplicate_mcq_questions.py.

That script blanks out component_mcq.question when it duplicates the
sibling "text" component's content, fixing the duplicate-question bug for
the base (English) locale. But per-locale overrides live in the separate
content_translation table (table_name='component_mcq', field_name='question'),
written by annexes/automation_server/src/database/translation_importer.py.
upsert_translation() never clears a row for an empty/blank value (so blank
Excel cells don't wipe a real translation) - which means translated
component_mcq.question values that were imported before the excel_loader.py
fix stay stuck in content_translation even after re-importing with fixed
source data. This script deletes those stale rows directly, one locale at a
time, by comparing each MCQ's translated question against the translated
content of its card's sibling text component (falling back to the base
component_text.content when no translation exists for that locale).

GEBRUIK
  python3 cleanup_duplicate_mcq_question_translations.py                # dry run, alle locales
  python3 cleanup_duplicate_mcq_question_translations.py --apply
  python3 cleanup_duplicate_mcq_question_translations.py --locale cs --apply
  python3 cleanup_duplicate_mcq_question_translations.py --owner-type simulator --owner-id 2 --apply

Databaseconfig (default = lokale dev DB, zoals generate_audios_google.py):
  DB_HOST, DB_USER, DB_PASSWORD, DB_NAME als env vars, anders localhost/root/""/elevather.
"""
import argparse
import os

import mysql.connector

DB_CONFIG = {
    "host": os.environ.get("DB_HOST", "localhost"),
    "user": os.environ.get("DB_USER", "root"),
    "password": os.environ.get("DB_PASSWORD", ""),
    "database": os.environ.get("DB_NAME", "elevather"),
}


def find_duplicates(cursor, owner_type=None, owner_id=None, locale=None):
    """Yield (card, mcq_id, locale, translation_id, question_value) for every
    per-locale MCQ question translation that duplicates the (translated or
    base) sibling text component content on the same card."""
    query = "SELECT * FROM card WHERE 1=1"
    params = []
    if owner_type:
        query += " AND owner_type=%s"
        params.append(owner_type)
    if owner_id:
        query += " AND owner_id=%s"
        params.append(owner_id)
    cursor.execute(query, params)
    cards = cursor.fetchall()

    for card in cards:
        cursor.execute(
            "SELECT * FROM card_contains WHERE card_id=%s ORDER BY component_order_index",
            (card["id"],),
        )
        links = cursor.fetchall()

        text_component_ids = []
        mcq_ids = []
        for link in links:
            ctype = link["component_type"].lower().strip()
            if ctype == "text":
                text_component_ids.append(link["component_id"])
            elif ctype == "mcq":
                mcq_ids.append(link["component_id"])

        if not text_component_ids or not mcq_ids:
            continue

        # Base (untranslated) content, used as a fallback for locales that
        # never got their own translation row for the text component.
        base_text_contents = set()
        for tid in text_component_ids:
            cursor.execute("SELECT content FROM component_text WHERE id=%s", (tid,))
            row = cursor.fetchone()
            if row and row.get("content"):
                base_text_contents.add(row["content"].strip())

        # locale -> set of translated text contents for this card's text components
        text_translations_by_locale = {}
        if text_component_ids:
            fmt = ",".join(["%s"] * len(text_component_ids))
            cursor.execute(
                f"SELECT locale, value FROM content_translation "
                f"WHERE table_name='component_text' AND field_name='content' AND row_id IN ({fmt})",
                tuple(text_component_ids),
            )
            for row in cursor.fetchall():
                text_translations_by_locale.setdefault(row["locale"], set()).add(row["value"].strip())

        query2 = (
            "SELECT id, row_id AS mcq_id, locale, value FROM content_translation "
            "WHERE table_name='component_mcq' AND field_name='question' AND row_id IN ({})"
        ).format(",".join(["%s"] * len(mcq_ids)))
        params2 = list(mcq_ids)
        if locale:
            query2 += " AND locale=%s"
            params2.append(locale)
        cursor.execute(query2, params2)
        mcq_translations = cursor.fetchall()

        for t in mcq_translations:
            value = (t["value"] or "").strip()
            if not value:
                continue
            allowed = text_translations_by_locale.get(t["locale"], base_text_contents)
            if value in allowed or value in base_text_contents:
                yield card, t["mcq_id"], t["locale"], t["id"], value


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--owner-type", choices=["simulator", "module"], default=None)
    parser.add_argument("--owner-id", type=int, default=None)
    parser.add_argument("--locale", default=None, help="Restrict to one locale (e.g. cs, de)")
    parser.add_argument("--apply", action="store_true", help="Actually update the DB (default: dry run)")
    args = parser.parse_args()

    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)

    found = list(find_duplicates(cursor, args.owner_type, args.owner_id, args.locale))

    if not found:
        print("No duplicate MCQ question translations found.")
        return

    print(f"Found {len(found)} content_translation row(s) duplicating their card's text component:\n")
    for card, mcq_id, locale, translation_id, value in found:
        preview = value[:80].replace("\n", " ")
        print(f"  card_id={card['id']} (owner_type={card['owner_type']}, owner_id={card['owner_id']}, "
              f"order={card['card_order_index']}) mcq_id={mcq_id} locale={locale!r}: {preview!r}...")

    if not args.apply:
        print("\nDry run - no changes made. Re-run with --apply to delete these translation rows.")
        return

    update_cursor = conn.cursor()
    ids = [translation_id for _, _, _, translation_id, _ in found]
    fmt = ",".join(["%s"] * len(ids))
    update_cursor.execute(f"DELETE FROM content_translation WHERE id IN ({fmt})", tuple(ids))
    conn.commit()
    print(f"\nDeleted {len(found)} duplicate content_translation row(s).")


if __name__ == "__main__":
    main()
