#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix simulator cards where the MCQ component's question duplicates the
sibling "text" component on the same card (the situation text ends up
rendered twice on screen: once as the text paragraph, once as the MCQ's
question label).

Root cause: annexes/automation_server/src/utils/excel_loader.py used to set
the MCQ's "content" (-> component_mcq.question) to the same "Situation Text"
already added as a separate text component. That's fixed for future imports;
this script clears the duplicate on cards already imported.

GEBRUIK
  python3 cleanup_duplicate_mcq_questions.py                # dry run, alle cards
  python3 cleanup_duplicate_mcq_questions.py --apply         # daadwerkelijk updaten
  python3 cleanup_duplicate_mcq_questions.py --owner-type simulator --owner-id 2 --apply

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


def find_duplicates(cursor, owner_type=None, owner_id=None):
    """Yield (card, mcq_link, mcq_row, text_row) for every card where the
    MCQ question exactly matches a sibling text component's content."""
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

        text_contents = []
        mcq_links = []
        for link in links:
            ctype = link["component_type"].lower().strip()
            if ctype == "text":
                cursor.execute("SELECT * FROM component_text WHERE id=%s", (link["component_id"],))
                row = cursor.fetchone()
                if row and row.get("content"):
                    text_contents.append(row["content"].strip())
            elif ctype == "mcq":
                mcq_links.append(link)

        for link in mcq_links:
            cursor.execute("SELECT * FROM component_mcq WHERE id=%s", (link["component_id"],))
            mcq_row = cursor.fetchone()
            if not mcq_row or not mcq_row.get("question"):
                continue
            question = mcq_row["question"].strip()
            if question and question in text_contents:
                yield card, link, mcq_row


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--owner-type", choices=["simulator", "module"], default=None)
    parser.add_argument("--owner-id", type=int, default=None)
    parser.add_argument("--apply", action="store_true", help="Actually update the DB (default: dry run)")
    args = parser.parse_args()

    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)

    found = list(find_duplicates(cursor, args.owner_type, args.owner_id))

    if not found:
        print("No duplicate MCQ questions found.")
        return

    print(f"Found {len(found)} MCQ component(s) duplicating their card's text component:\n")
    for card, link, mcq_row in found:
        preview = mcq_row["question"][:80].replace("\n", " ")
        print(f"  card_id={card['id']} (owner_type={card['owner_type']}, owner_id={card['owner_id']}, "
              f"order={card['card_order_index']}) mcq_id={mcq_row['id']!r}: {preview!r}...")

    if not args.apply:
        print("\nDry run - no changes made. Re-run with --apply to clear these questions.")
        return

    update_cursor = conn.cursor()
    for _, _, mcq_row in found:
        update_cursor.execute(
            "UPDATE component_mcq SET question=%s WHERE id=%s",
            ("", mcq_row["id"]),
        )
    conn.commit()
    print(f"\nCleared question on {len(found)} MCQ component(s).")


if __name__ == "__main__":
    main()
