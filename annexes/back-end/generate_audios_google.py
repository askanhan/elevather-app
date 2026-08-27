#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ElevatHer - genereert 1 mp3 per card (net als de bestaande Kokoro-audios)
via Google Cloud TTS, rechtstreeks vanuit de database. Geen Django nodig -
draai dit los, upload de output-map ("audios/") daarna zelf naar de server.

GEBRUIK
  export GOOGLE_TTS_KEY="AIza..."
  python3 generate_audios_google.py                    # alle modules, Engels
  python3 generate_audios_google.py --day 1             # enkel module dag 1
  python3 generate_audios_google.py --day 1 --language fr
  python3 generate_audios_google.py --owner-type simulator --owner-id 2
  python3 generate_audios_google.py --stemmen --language fr   # beschikbare stemmen tonen

Databaseconfig (default = lokale dev DB, zoals automation_server/config/database.py):
  DB_HOST, DB_USER, DB_PASSWORD, DB_NAME als env vars, anders localhost/root/""/elevather.
"""
import argparse
import base64
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request
from io import BytesIO
from pathlib import Path

import mysql.connector
from pydub import AudioSegment

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------

DB_CONFIG = {
    "host": os.environ.get("DB_HOST", "localhost"),
    "user": os.environ.get("DB_USER", "root"),
    "password": os.environ.get("DB_PASSWORD", ""),
    "database": os.environ.get("DB_NAME", "elevather"),
}

KEY = os.environ.get("GOOGLE_TTS_KEY", "")
BASE_URL = "https://texttospeech.googleapis.com/v1"

# Google's Chirp3-HD voices share the same character names across locales
# (Charon, Sulafat, Puck, ...). These are a starting point per language -
# run --stemmen --language <code> first to see what's actually available
# before trusting one for a language that isn't listed here yet.
VOICES = {
    "en": "en-US-Chirp3-HD-Charon",
    "fr": "fr-FR-Chirp3-HD-Charon",
    "nl": "nl-BE-Chirp3-HD-Sulafat",
}
DEFAULT_LANGUAGE = "en"
SPEAKING_RATE = 0.94

# Google TTS caps input.text at 5000 bytes per request; stay under that.
MAX_CHUNK_BYTES = 4500

OUTPUT_DIR = Path(__file__).parent / "audios"


# ---------------------------------------------------------------------------
# Google Cloud TTS (rechtstreekse REST calls, zelfde stijl als depart_google_tts.py)
# ---------------------------------------------------------------------------

def api(pad, payload=None):
    url = f"{BASE_URL}/{pad}" + ("?" if "?" not in pad else "&") + "key=" + KEY
    data = json.dumps(payload).encode() if payload is not None else None
    req = urllib.request.Request(url, data=data,
                                  headers={"Content-Type": "application/json; charset=utf-8"})
    with urllib.request.urlopen(req, timeout=120) as r:
        return json.loads(r.read().decode())


def synth(text, voice):
    """Chirp3-HD accepteert niet alle audioConfig-velden; val terug bij een 400."""
    varianten = [
        {"audioEncoding": "MP3", "speakingRate": SPEAKING_RATE,
         "effectsProfileId": ["headphone-class-device"]},
        {"audioEncoding": "MP3", "speakingRate": SPEAKING_RATE},
        {"audioEncoding": "MP3"},
    ]
    laatste = ""
    for cfg in varianten:
        try:
            res = api("text:synthesize", {
                "input": {"text": text},
                "voice": {"languageCode": voice[:5], "name": voice},
                "audioConfig": cfg,
            })
            audio_content = res.get("audioContent")
            return (base64.b64decode(audio_content), None) if audio_content else (None, "empty audioContent")
        except urllib.error.HTTPError as e:
            laatste = f"{e.code}: {e.read().decode()[:300]}"
            if e.code != 400:
                return None, laatste
    return None, laatste


def toon_stemmen(language_code):
    voices = api(f"voices?languageCode={language_code}").get("voices", [])
    for v in voices:
        print("  %-34s %s" % (v["name"], v.get("ssmlGender", "")))


def chunk_text(text, max_bytes=MAX_CHUNK_BYTES):
    paragraphs = [p.strip() for p in text.split("\n") if p.strip()]
    chunks = []
    current = ""

    def fits(candidate):
        return len(candidate.encode("utf-8")) <= max_bytes

    for para in paragraphs:
        candidate = f"{current}\n{para}" if current else para
        if fits(candidate):
            current = candidate
            continue
        if current:
            chunks.append(current)
            current = ""
        if fits(para):
            current = para
            continue
        # One paragraph on its own is too long: split on sentence boundaries.
        for sentence in re.split(r"(?<=[.!?])\s+", para):
            candidate = f"{current} {sentence}".strip() if current else sentence
            if fits(candidate):
                current = candidate
            else:
                if current:
                    chunks.append(current)
                current = sentence

    if current:
        chunks.append(current)
    return chunks


def text_to_segment(text, voice):
    segment = AudioSegment.empty()
    for chunk in chunk_text(text):
        audio_bytes, err = synth(chunk, voice)
        if not audio_bytes:
            raise RuntimeError(f"Google TTS failed: {err}")
        segment += AudioSegment.from_file(BytesIO(audio_bytes), format="mp3")
        time.sleep(0.12)
    return segment


# ---------------------------------------------------------------------------
# Database - card_contains -> componenten (kolommen zoals in api/models.py)
# ---------------------------------------------------------------------------

def is_valid_text(text):
    if not text:
        return False
    stripped = text.strip()
    if not stripped:
        return False
    if stripped.lower() == "nan":
        return False
    return True


def localized_text(base_text, table, row_id, field, language):
    """
    Geeft de tekst terug om voor te lezen, in `language`, voor 1 veld van 1 rij
    (bv. table='component_text', field='content').

    Er bestaat nog geen vertaaltabel, dus dit geeft altijd de originele tekst
    terug. Zodra vertalingen bestaan (een tabel met table/row_id/field/
    language_code, of gelijkaardig), zoek de vertaling hier op en val terug
    op base_text als ze ontbreekt. Elke andere functie geeft `language` al
    door tot hier, dus enkel deze functie moet later aangepast worden.
    """
    if not base_text or language == DEFAULT_LANGUAGE:
        return base_text
    # TODO: vertaaltabel opvragen zodra ze bestaat; fallback op base_text.
    return base_text


def fetch_one(cursor, table, row_id):
    cursor.execute(f"SELECT * FROM {table} WHERE id=%s", (row_id,))
    return cursor.fetchone()


def build_mcq_options_text(cursor, mcq_id, exclude_feedback, language):
    cursor.execute("SELECT * FROM multiple_choices_options WHERE mcq_id=%s", (mcq_id,))
    options_text = ""
    for option in cursor.fetchall():
        option_text = localized_text(option.get("option_text") or "", "multiple_choices_options",
                                      option["id"], "option_text", language)
        if not is_valid_text(option_text):
            continue
        options_text += f"\n{option_text}"
        if option.get("feedback") and not exclude_feedback:
            feedback = localized_text(option["feedback"], "multiple_choices_options",
                                       option["id"], "feedback", language)
            if is_valid_text(feedback):
                options_text += f" (Feedback: {feedback})"
    return options_text.strip()


def get_component_text(cursor, component_type, component_id, exclude_feedback, language):
    """
    Haalt tekst op van 1 component. Ondersteunt: text, title, subtitle, list,
    quote, mcq, open_questions, last_message(s). Slaat image/video over.
    """
    original_type = component_type
    component_type = component_type.lower().strip().replace(" ", "_")
    component_type = component_type.replace("las_messages", "last_message")
    component_type = component_type.replace("last_messages", "last_message")
    component_type = component_type.replace("component_last_messages", "last_message")
    component_type = component_type.replace("component_last_message", "last_message")
    component_type = component_type.replace("open_questions", "open_question")
    component_type = component_type.replace("component_open_questions", "open_question")
    component_type = component_type.replace("openquestion", "open_question")

    if component_type in ("image", "video"):
        return ""

    try:
        if component_type == "text":
            row = fetch_one(cursor, "component_text", component_id)
            content = localized_text(row["content"] if row else "", "component_text", component_id, "content", language)
            return content if is_valid_text(content) else ""

        elif component_type == "title":
            row = fetch_one(cursor, "component_title", component_id)
            content = localized_text(row["content"] if row else "", "component_title", component_id, "content", language)
            return content if is_valid_text(content) else ""

        elif component_type == "subtitle":
            row = fetch_one(cursor, "component_subtitle", component_id)
            content = localized_text(row["content"] if row else "", "component_subtitle", component_id, "content", language)
            return content if is_valid_text(content) else ""

        elif component_type == "list":
            row = fetch_one(cursor, "component_list", component_id)
            content = localized_text(row["content"] if row else "", "component_list", component_id, "content", language)
            return content if is_valid_text(content) else ""

        elif component_type == "quote":
            row = fetch_one(cursor, "component_quote", component_id)
            content = localized_text(row["content"] if row else "", "component_quote", component_id, "content", language)
            author = localized_text(row["author"] if row else "", "component_quote", component_id, "author", language)
            if is_valid_text(content) and is_valid_text(author):
                return f"{content} - {author}"
            elif is_valid_text(content):
                return content
            return ""

        elif component_type == "mcq":
            row = fetch_one(cursor, "component_mcq", component_id)
            text = localized_text(row["question"] if row else "", "component_mcq", component_id, "question", language)
            options_text = build_mcq_options_text(cursor, component_id, exclude_feedback, language)
            if options_text:
                text = f"{text}\n{options_text}" if text else options_text
            return text if is_valid_text(text) else ""

        elif component_type == "open_question":
            row = fetch_one(cursor, "component_open_questions", component_id)
            text = localized_text(row["question"] if row else "", "component_open_questions", component_id, "question", language)
            if row and row.get("placeholder"):
                placeholder = localized_text(row["placeholder"], "component_open_questions", component_id, "placeholder", language)
                if is_valid_text(placeholder):
                    text += f" ({placeholder})"
            return text if is_valid_text(text) else ""

        elif component_type == "last_message":
            row = fetch_one(cursor, "component_last_messages", component_id)
            content = localized_text(row["content"] if row else "", "component_last_messages", component_id, "content", language)
            return content if is_valid_text(content) else ""

        else:
            print(f"[WARNING] Unknown component type: '{original_type}' (normalized: '{component_type}') ID: {component_id}")
            return ""

    except Exception as e:
        print(f"[ERROR] Getting text for {component_type} ID {component_id}: {str(e)}")
        return ""


def extract_text_from_card(cursor, card, exclude_feedback, language):
    """Alle voorleesbare tekst van 1 card + z'n componenten, in `language`."""
    texts = []
    added_texts = set()

    title = localized_text(card.get("title") or "", "card", card["id"], "title", language)
    subtitle = localized_text(card.get("subtitle") or "", "card", card["id"], "subtitle", language)

    if is_valid_text(title):
        texts.append(title)
        added_texts.add(title.strip())
    if is_valid_text(subtitle):
        texts.append(subtitle)
        added_texts.add(subtitle.strip())

    cursor.execute("SELECT * FROM card_contains WHERE card_id=%s ORDER BY component_order_index", (card["id"],))
    card_components = cursor.fetchall()

    for link in card_components:
        component_type = link["component_type"]
        component_id = link["component_id"]

        try:
            text_content = get_component_text(cursor, component_type, component_id, exclude_feedback, language)
            if not is_valid_text(text_content):
                continue

            text_stripped = text_content.strip()
            if text_stripped in added_texts:
                continue

            if component_type.lower() == "mcq":
                mcq_row = fetch_one(cursor, "component_mcq", component_id)
                if mcq_row:
                    mcq_question = localized_text(mcq_row.get("question") or "", "component_mcq",
                                                   component_id, "question", language)
                    if is_valid_text(mcq_question) and mcq_question.strip() in added_texts:
                        options_text = build_mcq_options_text(cursor, component_id, exclude_feedback, language)
                        if is_valid_text(options_text) and options_text not in added_texts:
                            texts.append(options_text)
                            added_texts.add(options_text)
                        continue

            if component_type.lower() == "title" and title and text_stripped == title.strip():
                continue
            elif component_type.lower() == "subtitle" and subtitle and text_stripped == subtitle.strip():
                continue
            elif component_type.lower() == "text":
                if (title and text_stripped == title.strip()) or (subtitle and text_stripped == subtitle.strip()):
                    continue

            texts.append(text_content)
            added_texts.add(text_stripped)
        except Exception as e:
            print(f"Error extracting text from {component_type} {component_id}: {str(e)}")
            continue

    end_text = localized_text(card.get("end_text") or "", "card", card["id"], "end_text", language)
    if is_valid_text(end_text) and end_text.strip() not in added_texts:
        texts.append(end_text)
        added_texts.add(end_text.strip())

    why_text = localized_text(card.get("why_this_question") or "", "card", card["id"], "why_this_question", language)
    if is_valid_text(why_text) and why_text.strip() not in added_texts:
        texts.append(why_text)
        added_texts.add(why_text.strip())

    return "\n".join(texts)


def get_modules(cursor, day_number=None):
    if day_number is not None:
        cursor.execute("SELECT * FROM module WHERE day_number=%s", (day_number,))
    else:
        cursor.execute("SELECT * FROM module ORDER BY day_number")
    return cursor.fetchall()


def get_cards_for_owner(cursor, owner_type, owner_id):
    cursor.execute("SELECT * FROM card WHERE owner_type=%s AND owner_id=%s ORDER BY card_order_index",
                    (owner_type, owner_id))
    return cursor.fetchall()


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def generate_audio_for_card(cursor, card, voice, language, exclude_feedback, output_dir):
    """Genereert 1 mp3 voor 1 card. Bestandsnaam = zelfde formaat als de Kokoro-audios."""
    text = extract_text_from_card(cursor, card, exclude_feedback, language)
    if not is_valid_text(text):
        return None

    segment = text_to_segment(text, voice)

    # suffix = "" if language == DEFAULT_LANGUAGE else f"_{language}"
    filename = f"{language}_{card['id']}.mp3"
    output_dir.mkdir(parents=True, exist_ok=True)
    segment.export(output_dir / filename, format="mp3", bitrate="192k")
    return filename


def main():
    parser = argparse.ArgumentParser(description="Genereer card-audios via Google Cloud TTS, rechtstreeks uit de DB.")
    parser.add_argument("--day", type=int, default=None,
                         help="Enkel de module met dit day_number. Zonder deze flag: alle modules.")
    parser.add_argument("--owner-type", type=str, default="module",
                         help="'module' (default) of 'simulator'.")
    parser.add_argument("--owner-id", type=int, default=None,
                         help="Specifieke owner_id (overschrijft --day, enkel die ene owner).")
    parser.add_argument("--language", type=str, default=DEFAULT_LANGUAGE,
                         help=f"Taalcode (default: {DEFAULT_LANGUAGE}). De tekst zelf komt nog altijd uit de DB.")
    parser.add_argument("--voice", type=str, default=None, help="Google TTS stem (default: afgeleid van --language).")
    parser.add_argument("--include-feedback", action="store_true", help="MCQ-feedback ook voorlezen (default: nee).")
    parser.add_argument("--output-dir", type=str, default=None, help=f"Default: {OUTPUT_DIR}")
    parser.add_argument("--stemmen", action="store_true", help="Toon beschikbare stemmen voor --language en stop.")
    args = parser.parse_args()

    if args.stemmen:
        if not KEY:
            sys.exit("Zet eerst GOOGLE_TTS_KEY.")
        language_code = VOICES.get(args.language, args.language)[:5]
        toon_stemmen(language_code)
        return

    if not KEY:
        sys.exit("Zet eerst GOOGLE_TTS_KEY: export GOOGLE_TTS_KEY=\"...\"")

    voice = args.voice or VOICES.get(args.language, VOICES[DEFAULT_LANGUAGE])
    output_dir = Path(args.output_dir) if args.output_dir else OUTPUT_DIR
    exclude_feedback = not args.include_feedback

    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)

    try:
        if args.owner_id is not None:
            owners = [{"owner_type": args.owner_type, "owner_id": args.owner_id, "label": f"{args.owner_type} {args.owner_id}"}]
        else:
            modules = get_modules(cursor, args.day)
            if args.day is not None and not modules:
                sys.exit(f"Geen module gevonden met day_number={args.day}")
            owners = [{"owner_type": "module", "owner_id": m["id"], "label": f"module day {m['day_number']} - {m['title']}"}
                      for m in modules]

        generated = skipped = failed = 0

        for owner in owners:
            cards = get_cards_for_owner(cursor, owner["owner_type"], owner["owner_id"])
            print(f"\n{owner['label']}: {len(cards)} cards")
            for card in cards:
                try:
                    filename = generate_audio_for_card(cursor, card, voice, args.language, exclude_feedback, output_dir)
                    if filename:
                        print(f"  [ok] {filename}")
                        generated += 1
                    else:
                        print(f"  [skip] card {card['id']} - geen tekst")
                        skipped += 1
                except Exception as e:
                    print(f"  [FOUT] card {card['id']}: {e}")
                    failed += 1

        print("-" * 60)
        print(f"Klaar: {generated} gegenereerd, {skipped} overgeslagen, {failed} fout(en). -> {output_dir}")

    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    main()
