#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ElevatHer - genereert 1 mp3 per card voor een NIET-Engelse taal, via Google
Cloud TTS. De Engelse tekst zit rechtstreeks in de basistabellen (card,
component_*, ...) en wordt daarvoor door generate_audios_google.py gebruikt.
Voor elke andere taal zit de tekst in de vertaaltabel `content_translation`
(kolommen: table_name, row_id, field_name, locale, value), gevuld door de
automation_server import-scripts.

Dit script is met opzet "safe by default":
  - Zonder --generate doet het NIETS dan een AUDIT: het loopt alle cards af,
    kijkt welke velden een vertaling missen voor de gekozen taal, en toont/
    schrijft een rapport. Geen API-calls, geen kosten, geen bestanden.
  - Met --generate worden er pas echt audio's aangemaakt, en dan ENKEL voor
    cards waarvan alle voorleesbare velden een vertaling hebben. Een card met
    een missende vertaling wordt overgeslagen (en gerapporteerd) tenzij je
    --allow-partial meegeeft (dan valt die ene ontbrekende zin terug op het
    Engels - resulteert dus in gemengde taal, enkel gebruiken als je dat echt
    wil).
  - Er wordt altijd een rapportbestand weggeschreven (audios/<taal>/report_
    <taal>.txt) zodat je missende vertalingen kan nakijken/aanvullen voor je
    (opnieuw) --generate draait.

GEBRUIK
  export GOOGLE_TTS_KEY="AIza..."
  python3 generate_audios_google_translations.py --language fr                    # enkel audit
  python3 generate_audios_google_translations.py --language fr --generate         # genereert
  python3 generate_audios_google_translations.py --language fr --day 1 --generate
  python3 generate_audios_google_translations.py --languages fr,nl,de --generate  # meerdere talen na elkaar
  python3 generate_audios_google_translations.py --language fr --card-id 123 --generate  # 1 card testen
  python3 generate_audios_google_translations.py --language fr --stemmen          # beschikbare stemmen tonen

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

# Startpunt per taal - NIET blindelings vertrouwen. Chirp3-HD is niet overal
# beschikbaar; draai altijd --stemmen --language <code> en controleer de naam
# hieronder voor je een taal voor het eerst met --generate draait. Het script
# controleert dit ook zelf (zie check_voice) en stopt als de stem niet bestaat
# voor die taal, tenzij --skip-voice-check.
VOICES = {
    "fr": "fr-FR-Chirp3-HD-Charon",
    "nl": "nl-BE-Chirp3-HD-Sulafat",
    "de": "de-DE-Chirp3-HD-Charon",
    "tr": "tr-TR-Chirp3-HD-Charon",
    "cs": "cs-CZ-Chirp3-HD-Charon",
    "el": "el-GR-Chirp3-HD-Charon",
    "pl": "pl-PL-Chirp3-HD-Charon",
}
ENGLISH = "en"  # brontaal, zit rechtstreeks in de basistabellen - gebruik generate_audios_google.py hiervoor
SPEAKING_RATE = 0.94

# Google TTS caps input.text at 5000 bytes per request; stay under that.
MAX_CHUNK_BYTES = 4500

OUTPUT_DIR = Path(__file__).parent / "audios"

# component_contains.component_type (korte enum-labels) -> echte DB-tabelnaam
# in content_translation.table_name. Zie translation_coverage.py in
# annexes/automation_server voor de bron van deze mapping.
COMPONENT_TABLE_NAME = {
    "text": "component_text",
    "title": "component_title",
    "subtitle": "component_subtitle",
    "list": "component_list",
    "quote": "component_quote",
    "mcq": "component_mcq",
    "open_question": "component_open_questions",
    "last_message": "component_last_messages",
}
CARD_TABLE_NAME = "card"
MCQ_OPTIONS_TABLE_NAME = "multiple_choices_options"


# ---------------------------------------------------------------------------
# Google Cloud TTS (rechtstreekse REST calls, zelfde stijl als generate_audios_google.py)
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


def list_voices(language_code):
    return api(f"voices?languageCode={language_code}").get("voices", [])


def toon_stemmen(language_code):
    for v in list_voices(language_code):
        print("  %-34s %s" % (v["name"], v.get("ssmlGender", "")))


def check_voice(language, voice):
    """Bevestigt dat `voice` echt bestaat voor `language` voor we geld uitgeven.
    Geeft (ok, message) terug."""
    try:
        voices = list_voices(voice[:5])
    except Exception as e:
        return False, f"Kon stemmenlijst niet ophalen voor '{voice[:5]}': {e}"
    names = {v["name"] for v in voices}
    if voice in names:
        return True, ""
    beschikbaar = ", ".join(sorted(names)) or "(geen stemmen gevonden voor deze taalcode)"
    return False, (f"Stem '{voice}' bestaat niet voor taal '{language}'. "
                    f"Beschikbaar: {beschikbaar}")


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


def split_in_half(text):
    """Splitst tekst in 2 stukken, zo dicht mogelijk bij het midden en op een
    spatie (nooit midden in een woord)."""
    mid = len(text) // 2
    left = text.rfind(" ", 0, mid)
    right = text.find(" ", mid)
    candidates = [i for i in (left, right) if i != -1]
    if not candidates:
        return [text[:mid], text[mid:]]
    split_at = min(candidates, key=lambda i: abs(i - mid))
    return [text[:split_at].strip(), text[split_at:].strip()]


def synth_segment(text, voice, depth=0):
    """Synthetiseert 1 stuk tekst. Google's Chirp3-HD heeft een eigen (niet
    gedocumenteerde) limiet per "zin" - los van onze MAX_CHUNK_BYTES - die kan
    falen op lange zinnen zonder punctuatie (bv. lange bijzinnen, of
    stijlfiguren zoals herhaalde symbolen). Bij die specifieke fout wordt het
    stuk automatisch in tweeën gesplitst en apart geprobeerd, tot Google het
    accepteert."""
    audio_bytes, err = synth(text, voice)
    if audio_bytes:
        return AudioSegment.from_file(BytesIO(audio_bytes), format="mp3")

    if err and "too long" in err.lower() and depth < 8:
        parts = [p for p in split_in_half(text) if p]
        if len(parts) == 2:
            segment = AudioSegment.empty()
            for part in parts:
                segment += synth_segment(part, voice, depth + 1)
                time.sleep(0.12)
            return segment

    raise RuntimeError(f"Google TTS failed: {err}")


def text_to_segment(text, voice):
    segment = AudioSegment.empty()
    for chunk in chunk_text(text):
        segment += synth_segment(chunk, voice)
        time.sleep(0.12)
    return segment


# ---------------------------------------------------------------------------
# Vertalingen ophalen uit content_translation
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


def load_translation_cache(cursor, locale):
    """Laadt alle vertalingen voor 1 taal in 1 keer in (table_name, row_id,
    field_name) -> value, i.p.v. per veld een losse query te doen."""
    cursor.execute(
        "SELECT table_name, row_id, field_name, value FROM content_translation WHERE locale=%s",
        (locale,),
    )
    cache = {}
    for row in cursor.fetchall():
        cache[(row["table_name"], row["row_id"], row["field_name"])] = row["value"]
    return cache


class Translator:
    """Zoekt vertaalde tekst op en houdt bij welke velden een vertaling missen
    (enkel gerapporteerd als er wel Engelse brontekst is - een leeg veld hoeft
    niet vertaald te zijn)."""

    def __init__(self, cache, language):
        self.cache = cache
        self.language = language
        self.missing = []  # list of (table_name, row_id, field_name, english_preview)

    def text(self, base_text, table, row_id, field):
        value = self.cache.get((table, row_id, field))
        if is_valid_text(value):
            return value.strip()
        if is_valid_text(base_text):
            preview = base_text.strip().replace("\n", " ")[:60]
            self.missing.append((table, row_id, field, preview))
        return None


def fetch_one(cursor, table, row_id):
    cursor.execute(f"SELECT * FROM {table} WHERE id=%s", (row_id,))
    return cursor.fetchone()


def build_mcq_options_text(cursor, mcq_id, exclude_feedback, tr, allow_partial):
    cursor.execute("SELECT * FROM multiple_choices_options WHERE mcq_id=%s", (mcq_id,))
    options_text = ""
    for option in cursor.fetchall():
        base_option = option.get("option_text") or ""
        option_text = tr.text(base_option, MCQ_OPTIONS_TABLE_NAME, option["id"], "option_text")
        if option_text is None and allow_partial:
            option_text = base_option
        if not is_valid_text(option_text):
            continue
        options_text += f"\n{option_text}"
        if option.get("feedback") and not exclude_feedback:
            base_feedback = option["feedback"]
            feedback = tr.text(base_feedback, MCQ_OPTIONS_TABLE_NAME, option["id"], "feedback")
            if feedback is None and allow_partial:
                feedback = base_feedback
            if is_valid_text(feedback):
                options_text += f" (Feedback: {feedback})"
    return options_text.strip()


def get_component_text(cursor, component_type, component_id, exclude_feedback, tr, allow_partial):
    """Haalt vertaalde tekst op van 1 component. Ondersteunt: text, title,
    subtitle, list, quote, mcq, open_questions, last_message(s). Slaat
    image/video over (worden niet voorgelezen)."""
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

    table_name = COMPONENT_TABLE_NAME.get(component_type)
    if table_name is None:
        print(f"[WARNING] Unknown component type: '{original_type}' (normalized: '{component_type}') ID: {component_id}")
        return ""

    def field(base, name):
        val = tr.text(base, table_name, component_id, name)
        if val is None and allow_partial:
            val = base
        return val if is_valid_text(val) else ""

    try:
        if component_type == "text":
            row = fetch_one(cursor, "component_text", component_id)
            return field(row["content"] if row else "", "content")

        elif component_type == "title":
            row = fetch_one(cursor, "component_title", component_id)
            return field(row["content"] if row else "", "content")

        elif component_type == "subtitle":
            row = fetch_one(cursor, "component_subtitle", component_id)
            return field(row["content"] if row else "", "content")

        elif component_type == "list":
            row = fetch_one(cursor, "component_list", component_id)
            return field(row["content"] if row else "", "content")

        elif component_type == "quote":
            row = fetch_one(cursor, "component_quote", component_id)
            content = field(row["content"] if row else "", "content")
            author = field(row["author"] if row else "", "author")
            if is_valid_text(content) and is_valid_text(author):
                return f"{content} - {author}"
            elif is_valid_text(content):
                return content
            return ""

        elif component_type == "mcq":
            row = fetch_one(cursor, "component_mcq", component_id)
            text = field(row["question"] if row else "", "question")
            options_text = build_mcq_options_text(cursor, component_id, exclude_feedback, tr, allow_partial)
            if options_text:
                text = f"{text}\n{options_text}" if text else options_text
            return text if is_valid_text(text) else ""

        elif component_type == "open_question":
            row = fetch_one(cursor, "component_open_questions", component_id)
            text = field(row["question"] if row else "", "question")
            if row and row.get("placeholder"):
                placeholder = field(row["placeholder"], "placeholder")
                if is_valid_text(placeholder):
                    text += f" ({placeholder})"
            return text if is_valid_text(text) else ""

        elif component_type == "last_message":
            row = fetch_one(cursor, "component_last_messages", component_id)
            return field(row["content"] if row else "", "content")

        else:
            print(f"[WARNING] Unknown component type: '{original_type}' (normalized: '{component_type}') ID: {component_id}")
            return ""

    except Exception as e:
        print(f"[ERROR] Getting text for {component_type} ID {component_id}: {str(e)}")
        return ""


def extract_text_from_card(cursor, card, exclude_feedback, tr, allow_partial):
    """Alle voorleesbare tekst van 1 card + z'n componenten, vertaald.
    Vult tr.missing aan met elk veld dat brontekst had maar geen vertaling."""
    texts = []
    added_texts = set()

    def card_field(base, name):
        val = tr.text(base, CARD_TABLE_NAME, card["id"], name)
        if val is None and allow_partial:
            val = base
        return val if is_valid_text(val) else None

    title = card_field(card.get("title") or "", "title")
    subtitle = card_field(card.get("subtitle") or "", "subtitle")

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
            text_content = get_component_text(cursor, component_type, component_id, exclude_feedback, tr, allow_partial)
            if not is_valid_text(text_content):
                continue

            text_stripped = text_content.strip()
            if text_stripped in added_texts:
                continue

            if component_type.lower() == "mcq":
                mcq_row = fetch_one(cursor, "component_mcq", component_id)
                if mcq_row:
                    mcq_question = tr.text(mcq_row.get("question") or "", "component_mcq", component_id, "question")
                    if mcq_question is None and allow_partial:
                        mcq_question = mcq_row.get("question") or ""
                    if is_valid_text(mcq_question) and mcq_question.strip() in added_texts:
                        options_text = build_mcq_options_text(cursor, component_id, exclude_feedback, tr, allow_partial)
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

    end_text = card_field(card.get("end_text") or "", "end_text")
    if is_valid_text(end_text) and end_text.strip() not in added_texts:
        texts.append(end_text)
        added_texts.add(end_text.strip())

    why_text = card_field(card.get("why_this_question") or "", "why_this_question")
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


def get_card_by_id(cursor, card_id):
    cursor.execute("SELECT * FROM card WHERE id=%s", (card_id,))
    return cursor.fetchone()


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def process_card(cursor, card, exclude_feedback, allow_partial, translation_cache, language):
    """Bouwt de tekst van 1 card op en geeft (text, missing) terug. Doet geen
    API-calls - dit is dezelfde stap voor audit en generatie."""
    tr = Translator(translation_cache, language)
    text = extract_text_from_card(cursor, card, exclude_feedback, tr, allow_partial)
    return text, tr.missing


def run_language(cursor, language, owners, exclude_feedback, allow_partial, do_generate,
                  voice, output_dir, single_card_id):
    print(f"\n{'=' * 70}\nTaal: {language}\n{'=' * 70}")

    translation_cache = load_translation_cache(cursor, language)
    print(f"  {len(translation_cache)} vertaalde velden geladen uit content_translation voor locale='{language}'.")

    lang_output_dir = output_dir / language
    complete_cards = []   # (card, text)
    incomplete_cards = []  # (card, missing)
    empty_cards = []      # card zonder voorleesbare tekst uberhaupt

    for owner in owners:
        if single_card_id is not None:
            card = get_card_by_id(cursor, single_card_id)
            cards = [card] if card else []
            if not card:
                print(f"  [FOUT] card {single_card_id} niet gevonden.")
        else:
            cards = get_cards_for_owner(cursor, owner["owner_type"], owner["owner_id"])
        print(f"\n{owner['label']}: {len(cards)} cards")

        for card in cards:
            try:
                text, missing = process_card(cursor, card, exclude_feedback, allow_partial,
                                              translation_cache, language)
            except Exception as e:
                print(f"  [FOUT] card {card['id']}: kon tekst niet opbouwen: {e}")
                incomplete_cards.append((card, [("?", card["id"], "?", str(e))]))
                continue

            if not is_valid_text(text):
                print(f"  [skip] card {card['id']} - geen voorleesbare tekst")
                empty_cards.append(card)
                continue

            if missing and not allow_partial:
                print(f"  [MISSING] card {card['id']} - {len(missing)} veld(en) zonder vertaling, overgeslagen")
                incomplete_cards.append((card, missing))
                continue

            if missing and allow_partial:
                print(f"  [partial] card {card['id']} - {len(missing)} veld(en) vallen terug op Engels")

            complete_cards.append((card, text))

        if single_card_id is not None:
            break

    # ------------------------------------------------------------------
    # Rapport (altijd geschreven, ook bij audit-only)
    # ------------------------------------------------------------------
    lang_output_dir.mkdir(parents=True, exist_ok=True)
    report_path = lang_output_dir / f"report_{language}.txt"
    with open(report_path, "w", encoding="utf-8") as f:
        f.write(f"Vertaalrapport voor taal '{language}'\n")
        f.write(f"Klaar voor audio: {len(complete_cards)}\n")
        f.write(f"Missende vertalingen: {len(incomplete_cards)}\n")
        f.write(f"Geen tekst: {len(empty_cards)}\n\n")
        if incomplete_cards:
            f.write("Cards met missende vertaling(en):\n")
            for card, missing in incomplete_cards:
                f.write(f"\ncard {card['id']} ({card.get('title') or '(geen titel)'}):\n")
                for table, row_id, field, preview in missing:
                    f.write(f"  - {table}.{field} (row_id={row_id})  EN: \"{preview}\"\n")

    print(f"\n  Rapport weggeschreven: {report_path}")
    print(f"  Klaar voor audio: {len(complete_cards)} | Missende vertaling: {len(incomplete_cards)} | Geen tekst: {len(empty_cards)}")

    if incomplete_cards:
        print(f"  Let op: {len(incomplete_cards)} card(s) hebben missende vertalingen in content_translation "
              f"(locale='{language}') en worden overgeslagen. Zie {report_path} voor details, of gebruik "
              f"--allow-partial om toch te genereren met Engelse fallback voor de ontbrekende stukken.")

    if not do_generate:
        print("  [audit-only] Geen --generate meegegeven: er is niets aangemaakt of aangeroepen bij Google TTS.")
        return

    if not complete_cards:
        print("  Niets om te genereren voor deze taal.")
        return

    print(f"\n  Genereren van {len(complete_cards)} audio('s) voor taal '{language}'...")
    generated = failed = 0
    for card, text in complete_cards:
        try:
            segment = text_to_segment(text, voice)
            filename = f"{language}_{card['id']}.mp3"
            segment.export(lang_output_dir / filename, format="mp3", bitrate="192k")
            print(f"  [ok] {filename}")
            generated += 1
        except Exception as e:
            print(f"  [FOUT] card {card['id']}: {e}")
            failed += 1

    print(f"  Klaar voor '{language}': {generated} gegenereerd, {failed} fout(en). -> {lang_output_dir}")


def main():
    parser = argparse.ArgumentParser(
        description="Genereer card-audios in een niet-Engelse taal via Google Cloud TTS, "
                     "met tekst uit content_translation. Safe by default: audit-only tenzij --generate.")
    parser.add_argument("--language", type=str, default=None,
                         help="Eén taalcode, bv. fr, nl, de, tr, cs, el, pl.")
    parser.add_argument("--languages", type=str, default=None,
                         help="Kommagescheiden lijst van taalcodes, bv. fr,nl,de. Overschrijft --language.")
    parser.add_argument("--day", type=int, default=None,
                         help="Enkel de module met dit day_number. Zonder deze flag: alle modules.")
    parser.add_argument("--owner-type", type=str, default="module",
                         help="'module' (default) of 'simulator'.")
    parser.add_argument("--owner-id", type=int, default=None,
                         help="Specifieke owner_id (overschrijft --day, enkel die ene owner).")
    parser.add_argument("--card-id", type=int, default=None,
                         help="Enkel deze ene card verwerken (handig om 1 taal/card te testen voor je bulk draait).")
    parser.add_argument("--voice", type=str, default=None,
                         help="Google TTS stem (default: afgeleid van --language via VOICES).")
    parser.add_argument("--include-feedback", action="store_true", help="MCQ-feedback ook voorlezen (default: nee).")
    parser.add_argument("--output-dir", type=str, default=None, help=f"Default: {OUTPUT_DIR}")
    parser.add_argument("--generate", action="store_true",
                         help="Genereert echt audio's. Zonder deze flag: enkel audit + rapport, geen API-calls.")
    parser.add_argument("--allow-partial", action="store_true",
                         help="Genereer ook cards met missende vertaling(en); die stukken vallen terug op het "
                              "Engels (gemengde taal in de audio). Default: zulke cards overslaan.")
    parser.add_argument("--skip-voice-check", action="store_true",
                         help="Sla de controle over of --voice echt bestaat voor deze taal over.")
    parser.add_argument("--stemmen", action="store_true", help="Toon beschikbare stemmen voor --language en stop.")
    args = parser.parse_args()

    if args.languages:
        languages = [l.strip() for l in args.languages.split(",") if l.strip()]
    elif args.language:
        languages = [args.language]
    else:
        sys.exit("Geef --language of --languages mee.")

    for language in languages:
        if language == ENGLISH:
            sys.exit("Voor Engels: gebruik generate_audios_google.py (tekst zit al in de basistabellen).")

    if args.stemmen:
        if not KEY:
            sys.exit("Zet eerst GOOGLE_TTS_KEY.")
        for language in languages:
            voice = args.voice or VOICES.get(language, language)
            print(f"\nTaal '{language}':")
            toon_stemmen(voice[:5])
        return

    if not KEY:
        sys.exit("Zet eerst GOOGLE_TTS_KEY: export GOOGLE_TTS_KEY=\"...\"")

    output_dir = Path(args.output_dir) if args.output_dir else OUTPUT_DIR
    exclude_feedback = not args.include_feedback

    # Voorkom een dure/foute bulk-run: elke opgegeven taal moet een gekende
    # (of expliciet meegegeven) stem hebben, en die stem moet echt bestaan.
    voices_per_language = {}
    for language in languages:
        voice = args.voice or VOICES.get(language)
        if not voice:
            sys.exit(f"Geen stem gekend voor taal '{language}'. Geef --voice mee, of vul VOICES aan in het script "
                      f"(gebruik eerst --stemmen om te zien wat beschikbaar is).")
        voices_per_language[language] = voice

    if args.generate and not args.skip_voice_check:
        for language, voice in voices_per_language.items():
            ok, msg = check_voice(language, voice)
            if not ok:
                sys.exit(f"[FOUT] {msg}\nDraai --stemmen --language {language} om te kiezen, of geef --voice mee.")

    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)

    try:
        if args.card_id is not None:
            owners = [{"owner_type": "module", "owner_id": None, "label": f"card {args.card_id}"}]
        elif args.owner_id is not None:
            owners = [{"owner_type": args.owner_type, "owner_id": args.owner_id,
                       "label": f"{args.owner_type} {args.owner_id}"}]
        else:
            modules = get_modules(cursor, args.day)
            if args.day is not None and not modules:
                sys.exit(f"Geen module gevonden met day_number={args.day}")
            owners = [{"owner_type": "module", "owner_id": m["id"], "label": f"module day {m['day_number']} - {m['title']}"}
                      for m in modules]

        for language in languages:
            run_language(cursor, language, owners, exclude_feedback, args.allow_partial,
                         args.generate, voices_per_language[language], output_dir, args.card_id)

    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    main()
