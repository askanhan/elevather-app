import os
from django.core.management.base import BaseCommand
from django.conf import settings
from api.models import Card
from api.services.kokoro_card_tts_service import KokoroCardTTSService


class Command(BaseCommand):
    help = "Generate audio files for all cards using Kokoro TTS. Cleans old audios before regeneration."

    def add_arguments(self, parser):
        parser.add_argument(
            '--owner-type',
            type=str,
            default=None,
            help='Generate audios only for specific owner_type (e.g., "module", "simulator")',
        )
        parser.add_argument(
            '--owner-id',
            type=int,
            default=None,
            help='Generate audios only for specific owner_id',
        )
        parser.add_argument(
            '--keep-old',
            action='store_true',
            help='Keep old audio files instead of cleaning them',
        )
        parser.add_argument(
            '--voice',
            type=str,
            default='af_heart',
            help='Voice style for Kokoro TTS (default: af_heart)',
        )
        parser.add_argument(
            '--speed',
            type=float,
            default=0.9,
            help='Speech speed for Kokoro TTS (default: 0.9)',
        )
        parser.add_argument(
            '--include-feedback',
            action='store_true',
            help='Include feedback text from MCQ options (default is exclude)',
        )

    def handle(self, *args, **options):
        owner_type = options.get('owner_type')
        owner_id = options.get('owner_id')
        keep_old = options.get('keep_old')
        voice = options.get('voice')
        speed = options.get('speed')
        include_feedback = options.get('include_feedback')
        # Invert the logic: exclude_feedback is True by default, unless include_feedback is True
        exclude_feedback = not include_feedback

        # Create media/audios directory if it doesn't exist
        audio_dir = os.path.join(settings.MEDIA_ROOT, 'audios')
        os.makedirs(audio_dir, exist_ok=True)

        # Determine which cards to process
        if owner_type and owner_id:
            cards = Card.objects.filter(owner_type=owner_type, owner_id=owner_id).order_by('card_order_index')
            self.stdout.write(f"Processing {cards.count()} cards for {owner_type} {owner_id}...")
        else:
            cards = Card.objects.all().order_by('card_order_index')
            self.stdout.write(f"Processing {cards.count()} cards...")

        if cards.count() == 0:
            self.stdout.write(self.style.WARNING('No cards found to process.'))
            return

        # Clean old audio files if not keeping them
        if not keep_old:
            self._clean_old_audios()

        try:
            # Initialize Kokoro TTS service ONCE
            self.stdout.write("Initializing Kokoro TTS pipeline...")
            tts_service = KokoroCardTTSService(lang_code='a', voice=voice, speed=speed)
            self.stdout.write(self.style.SUCCESS("Kokoro pipeline initialized"))

            generated_count = 0
            failed_count = 0
            skipped_count = 0

            # Generate audio for each card
            for card in cards:
                try:
                    self.stdout.write(f"\nProcessing card {card.id} (owner: {card.owner_type} {card.owner_id})...", ending=" ")

                    # Generate audio (only saves to file, no DB update)
                    audio_path = tts_service.generate_audio_for_card(card, exclude_feedback=exclude_feedback)

                    if audio_path:
                        self.stdout.write(self.style.SUCCESS(f"Generated: {audio_path}"))
                        generated_count += 1
                    else:
                        self.stdout.write(self.style.WARNING("No text content to generate audio"))
                        skipped_count += 1

                except Exception as e:
                    self.stdout.write(self.style.ERROR(f"Failed: {str(e)}"))
                    failed_count += 1

            # Summary
            self.stdout.write("\n" + "="*60)
            self.stdout.write(self.style.SUCCESS(f"Generated: {generated_count} audio files"))
            if skipped_count > 0:
                self.stdout.write(self.style.WARNING(f"Skipped: {skipped_count} cards (no text content)"))
            if failed_count > 0:
                self.stdout.write(self.style.ERROR(f"Failed: {failed_count} cards"))
            self.stdout.write("="*60)

        except Exception as e:
            self.stdout.write(self.style.ERROR(f"Fatal error: {str(e)}"))
            import traceback
            traceback.print_exc()

    def _clean_old_audios(self):
        """
        Clean old audio files from media/audios directory.
        """
        audio_dir = os.path.join(settings.MEDIA_ROOT, 'audios')

        if not os.path.exists(audio_dir):
            self.stdout.write("No audio directory found, skipping cleanup.")
            return

        try:
            self.stdout.write("Cleaning old audio files...")
            for filename in os.listdir(audio_dir):
                file_path = os.path.join(audio_dir, filename)
                try:
                    if os.path.isfile(file_path):
                        os.unlink(file_path)
                        self.stdout.write(f"Deleted: {filename}")
                except Exception as e:
                    self.stdout.write(self.style.WARNING(f"Could not delete {filename}: {str(e)}"))

            self.stdout.write(self.style.SUCCESS(f"Cleanup complete"))

        except Exception as e:
            self.stdout.write(self.style.WARNING(f"Error during cleanup: {str(e)}"))


