        # Skip non-text components
import os
import soundfile as sf
from pathlib import Path
from django.conf import settings
from kokoro import KPipeline
from pydub import AudioSegment
from ..models import Card, CardContains, ComponentText, ComponentTitle, ComponentSubtitle, ComponentList, ComponentQuote, ComponentMCQ, ComponentOpenQuestion, ComponentLastMessage, MCQOptions


class KokoroCardTTSService:
    """
    Service to generate TTS (Text-To-Speech) audio for cards and their components.
    Uses Kokoro TTS to convert text to speech and saves as WAV files.
    """

    def __init__(self, lang_code: str = 'a', voice: str = 'af_heart', speed: float = 0.9):
        """
        Initialize the Kokoro TTS service.

        Args:
            lang_code: Language code for Kokoro ('a' for all, 'en' for English, etc.)
            voice: Voice style to use (default: 'af_bella' - calmer, clearer voice for better understanding)
            speed: Speech speed (default: 0.9 - slightly slower for better comprehension)
        """
        self.lang_code = lang_code
        self.voice = voice
        self.speed = speed

        # Initialize Kokoro pipeline
        self.pipeline = KPipeline(lang_code=lang_code)

        self.audio_dir = os.path.join(settings.MEDIA_ROOT, 'audios')
        os.makedirs(self.audio_dir, exist_ok=True)

    def _is_valid_text(self, text: str) -> bool:
        """
        Check if text is valid and should be read.
        Filters out "nan", empty strings, and whitespace-only strings.

        Args:
            text: Text to validate

        Returns:
            bool: True if text is valid and should be read, False otherwise
        """
        if not text:
            return False
        text_stripped = text.strip()
        if not text_stripped:
            return False
        if text_stripped.lower() == "nan":
            return False
        return True

    def extract_text_from_card(self, card: Card, exclude_feedback: bool = True) -> str:
        """
        Extract all readable text from a card and its components.
        Excludes images and videos.
        Avoids reading the same title/subtitle twice if they appear in both card and components.
        Also avoids reading duplicate text content from different components (case-sensitive comparison).
        Filters out "nan" text.

        Args:
            card: Card instance
            exclude_feedback: If True, excludes feedback text from MCQ options (useful for simulators)

        Returns:
            str: Concatenated text from all readable components
        """
        texts = []
        # Track already added texts to avoid duplicates (case-sensitive comparison)
        added_texts = set()

        # Add card title and subtitle
        if self._is_valid_text(card.title):
            texts.append(card.title)
            added_texts.add(card.title.strip())
        if self._is_valid_text(card.subtitle):
            texts.append(card.subtitle)
            added_texts.add(card.subtitle.strip())

        # Get all components associated with this card
        card_components = CardContains.objects.filter(card=card).order_by('component_order_index')

        for component_link in card_components:
            component_type = component_link.component_type
            component_id = component_link.component_id

            try:
                text_content = self._get_component_text(component_type, component_id, exclude_feedback=exclude_feedback)
                if self._is_valid_text(text_content):
                    # Normalize text for comparison (strip whitespace)
                    text_stripped = text_content.strip()

                    # Skip if this exact text has already been added
                    if text_stripped in added_texts:
                        continue

                    # For MCQ, special handling if the question was already added
                    # Check if only the question part was already added (in case TEXT component had the same question)
                    if component_type.lower() == 'mcq':
                        # Get the MCQ component to access its data directly
                        try:
                            mcq_component = ComponentMCQ.objects.get(id=component_id)
                            mcq_question = mcq_component.question if mcq_component.question else ""

                            # Check if the question was already added
                            if self._is_valid_text(mcq_question) and mcq_question.strip() in added_texts:
                                # Question was already added, but maybe there are options
                                # Rebuild options text WITHOUT the question and respecting exclude_feedback
                                options = MCQOptions.objects.filter(mcq=mcq_component)
                                if options.exists():
                                    options_text = ""
                                    for option in options:
                                        option_text = option.option_text if option.option_text else ""
                                        if self._is_valid_text(option_text):
                                            options_text += f"\n{option_text}"
                                            # Only add feedback if not excluded and feedback is valid
                                            if option.feedback and not exclude_feedback and self._is_valid_text(option.feedback):
                                                options_text += f" (Feedback: {option.feedback})"

                                    options_text = options_text.strip()
                                    if self._is_valid_text(options_text) and options_text not in added_texts:
                                        texts.append(options_text)
                                        added_texts.add(options_text)
                                # Continue to next component (question already read)
                                continue
                        except ComponentMCQ.DoesNotExist:
                            pass

                    # Avoid adding duplicate titles/subtitles
                    # If component is a title or subtitle, check if it matches card's title/subtitle
                    if component_type.lower() == 'title' and card.title and text_stripped == card.title.strip():
                        # Skip if it's the same as card title
                        continue
                    elif component_type.lower() == 'subtitle' and card.subtitle and text_stripped == card.subtitle.strip():
                        # Skip if it's the same as card subtitle
                        continue
                    # Also check if component text matches card title or subtitle
                    elif component_type.lower() == 'text':
                        if (card.title and text_stripped == card.title.strip()) or \
                           (card.subtitle and text_stripped == card.subtitle.strip()):
                            # Skip if text component matches card title or subtitle
                            continue

                    texts.append(text_content)
                    added_texts.add(text_stripped)
            except Exception as e:
                print(f"Error extracting text from {component_type} {component_id}: {str(e)}")
                continue

        # Add end_text if present
        if self._is_valid_text(card.end_text):
            end_text_stripped = card.end_text.strip()
            if end_text_stripped not in added_texts:
                texts.append(card.end_text)
                added_texts.add(end_text_stripped)

        # Add why_this_question if present
        if self._is_valid_text(card.why_this_question):
            why_text_stripped = card.why_this_question.strip()
            if why_text_stripped not in added_texts:
                texts.append(card.why_this_question)
                added_texts.add(why_text_stripped)

        return "\n".join(texts)

    def _get_component_text(self, component_type: str, component_id: int, exclude_feedback: bool = True) -> str:
        """
        Extract text from a specific component based on its type.
        Supports: text, title, subtitle, list, quote, mcq, open_questions, lastmessage, last_messages
            component_type: Type of component (e.g., 'text', 'title', 'list', etc.)
            component_id: ID of the component
            exclude_feedback: If True, excludes feedback text from MCQ options (useful for simulators)

        Returns:
            str: Text content from the component, or empty string if component type is image/video/nan
        """
        original_type = component_type
        component_type = component_type.lower().strip()

        # Normalize component type names to handle different naming conventions
        # Remove spaces and replace with underscores
        component_type = component_type.replace(' ', '_')

        # Normalize synonyms
        component_type = component_type.replace('las_messages', 'last_message')
        component_type = component_type.replace('last_messages', 'last_message')
        component_type = component_type.replace('component_last_messages', 'last_message')
        component_type = component_type.replace('component_last_message', 'last_message')
        component_type = component_type.replace('open_questions', 'open_question')
        component_type = component_type.replace('component_open_questions', 'open_question')
        component_type = component_type.replace('openquestion', 'open_question')

        # Skip non-text components
        if component_type in ['image', 'video']:
            return ""

        try:
            if component_type == 'text':
                component = ComponentText.objects.get(id=component_id)
                content = component.content if component.content else ""
                return content if self._is_valid_text(content) else ""

            elif component_type == 'title':
                component = ComponentTitle.objects.get(id=component_id)
                content = component.content if component.content else ""
                return content if self._is_valid_text(content) else ""

            elif component_type == 'subtitle':
                component = ComponentSubtitle.objects.get(id=component_id)
                content = component.content if component.content else ""
                return content if self._is_valid_text(content) else ""

            elif component_type == 'list':
                component = ComponentList.objects.get(id=component_id)
                content = component.content if component.content else ""
                return content if self._is_valid_text(content) else ""

            elif component_type == 'quote':
                component = ComponentQuote.objects.get(id=component_id)
                content = component.content if component.content else ""
                author = component.author if component.author else ""
                # Only add author if both content and author exist and are valid
                if self._is_valid_text(content) and self._is_valid_text(author):
                    return f"{content} - {author}"
                elif self._is_valid_text(content):
                    return content
                return ""

            elif component_type == 'mcq':
                component = ComponentMCQ.objects.get(id=component_id)
                text = component.question if component.question else ""
                # Add all MCQ options
                options = MCQOptions.objects.filter(mcq=component)
                for option in options:
                    option_text = option.option_text if option.option_text else ""
                    if self._is_valid_text(option_text):
                        text += f"\n{option_text}"
                        # Only add feedback if not excluded and feedback is valid
                        if option.feedback and not exclude_feedback and self._is_valid_text(option.feedback):
                            text += f" (Feedback: {option.feedback})"
                return text if self._is_valid_text(text) else ""

            elif component_type == 'open_question':
                component = ComponentOpenQuestion.objects.get(id=component_id)
                text = component.question if component.question else ""
                if component.placeholder and self._is_valid_text(component.placeholder):
                    text += f" ({component.placeholder})"
                return text if self._is_valid_text(text) else ""

            elif component_type == 'last_message':
                component = ComponentLastMessage.objects.get(id=component_id)
                content = component.content if component.content else ""
                return content if self._is_valid_text(content) else ""

            else:
                # Unknown component type - don't guess, just log and return empty
                print(f"[WARNING] Unknown component type: '{original_type}' (normalized: '{component_type}') ID: {component_id}")
                return ""

        except ComponentText.DoesNotExist:
            print(f"[ERROR] ComponentText ID {component_id} not found")
            return ""
        except ComponentTitle.DoesNotExist:
            print(f"[ERROR] ComponentTitle ID {component_id} not found")
            return ""
        except ComponentSubtitle.DoesNotExist:
            print(f"[ERROR] ComponentSubtitle ID {component_id} not found")
            return ""
        except ComponentList.DoesNotExist:
            print(f"[ERROR] ComponentList ID {component_id} not found")
            return ""
        except ComponentQuote.DoesNotExist:
            print(f"[ERROR] ComponentQuote ID {component_id} not found")
            return ""
        except ComponentMCQ.DoesNotExist:
            print(f"[ERROR] ComponentMCQ ID {component_id} not found")
            return ""
        except ComponentOpenQuestion.DoesNotExist:
            print(f"[ERROR] ComponentOpenQuestion ID {component_id} not found")
            return ""
        except ComponentLastMessage.DoesNotExist:
            print(f"[ERROR] ComponentLastMessage ID {component_id} not found")
            return ""
        except Exception as e:
            print(f"[ERROR] Getting text for {component_type} ID {component_id}: {str(e)}")
            return ""

    def generate_audio_for_card(self, card: Card, exclude_feedback: bool = True) -> str:
        """
        Generate audio file for a single card using Kokoro TTS.

        Args:
            card: Card instance
            exclude_feedback: If True, excludes feedback text from MCQ options (useful for simulators)

        Returns:
            str: Relative path to the generated audio file, or empty string if failed
        """
        # Extract all text from the card
        text = self.extract_text_from_card(card, exclude_feedback=exclude_feedback)

        if not text or not text.strip():
            return ""

        # Generate filename
        audio_filename_wav = f"card_{card.id}_{card.owner_type}_{card.owner_id}.wav"
        audio_filename_mp3 = audio_filename_wav.replace('.wav', '.mp3')
        audio_path_wav = os.path.join(self.audio_dir, audio_filename_wav)
        audio_path_mp3 = os.path.join(self.audio_dir, audio_filename_mp3)

        try:
            # Generate audio using Kokoro pipeline
            generator = self.pipeline(text, voice=self.voice, speed=self.speed)

            # Collect all audio chunks
            all_audio = None
            for gs, ps, audio in generator:
                if all_audio is None:
                    all_audio = audio
                else:
                    # Concatenate audio chunks
                    import numpy as np
                    all_audio = np.concatenate([all_audio, audio])

            if all_audio is not None:
                # Save as WAV file (Kokoro uses 24000 Hz sample rate)
                sf.write(audio_path_wav, all_audio, 24000)

                # Transform wav files to mp3
                audio_segment = AudioSegment.from_wav(audio_path_wav)
                audio_segment.export(audio_path_mp3, format="mp3", bitrate="192k")

                # Remove the original WAV file to save space
                if os.path.exists(audio_path_wav):
                    os.remove(audio_path_wav)

                # Return relative path (for storing in database)
                relative_path = f"audios/{audio_filename_mp3}"
                return relative_path
            else:
                print(f"No audio generated for card {card.id}")
                return ""

        except Exception as e:
            print(f"Error generating audio for card {card.id}: {str(e)}")
            import traceback
            traceback.print_exc()
            return ""

    def generate_audio_for_owner(self, owner_type: str, owner_id: int, exclude_feedback: bool = True) -> dict:
        """
        Generate audio files for all cards of a specific module or simulator.

        Args:
            owner_type: Type of owner ('module' or 'simulator')
            owner_id: ID of the owner
            exclude_feedback: If True, excludes feedback text from MCQ options (useful for simulators)

        Returns:
            dict: Dictionary with results of audio generation
        """
        # Get all cards for this owner
        cards = Card.objects.filter(owner_type=owner_type, owner_id=owner_id).order_by('card_order_index')

        if not cards.exists():
            return {
                'success': False,
                'message': f'No cards found for {owner_type} {owner_id}',
                'audio_count': 0
            }

        results = {
            'success': True,
            'owner_type': owner_type,
            'owner_id': owner_id,
            'total_cards': cards.count(),
            'generated_audios': [],
            'failed_cards': []
        }

        for card in cards:
            try:
                audio_path = self.generate_audio_for_card(card, exclude_feedback=exclude_feedback)
                if audio_path:
                    results['generated_audios'].append({
                        'card_id': card.id,
                        'audio_path': audio_path
                    })
                else:
                    results['failed_cards'].append({
                        'card_id': card.id,
                        'reason': 'No text content to generate audio'
                    })
            except Exception as e:
                results['failed_cards'].append({
                    'card_id': card.id,
                    'reason': str(e)
                })

        return results

    def generate_audio_for_single_card(self, card_id: int, exclude_feedback: bool = True) -> dict:
        """
        Generate audio file for a single card by ID.

        Args:
            card_id: ID of the card
            exclude_feedback: If True, excludes feedback text from MCQ options (useful for simulators)

        Returns:
            dict: Dictionary with result of audio generation
        """
        try:
            card = Card.objects.get(id=card_id)
            audio_path = self.generate_audio_for_card(card, exclude_feedback=exclude_feedback)

            if audio_path:
                return {
                    'success': True,
                    'card_id': card_id,
                    'audio_path': audio_path
                }
            else:
                return {
                    'success': False,
                    'card_id': card_id,
                    'reason': 'No text content to generate audio'
                }
        except Card.DoesNotExist:
            return {
                'success': False,
                'card_id': card_id,
                'reason': 'Card not found'
            }
        except Exception as e:
            return {
                'success': False,
                'card_id': card_id,
                'reason': str(e)
            }

