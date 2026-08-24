
import os
import random
from datetime import datetime, date
from django.utils import timezone

from firebase_admin import auth as fb_auth
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseForbidden, FileResponse
from django.views.decorators.csrf import ensure_csrf_cookie
from django.contrib.auth import get_user_model

from elevateher_backend import settings
from .models import *
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from rest_framework_simplejwt.tokens import RefreshToken
#from api.models import   Follow, PrivateMessage, Feedback, PrivateMessageBlocked, PrivateMessageHiddenConversation
from django.db.models import Q

from django.http import JsonResponse, HttpResponse
from django.contrib.auth.decorators import login_required
from django.utils.html import escape
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.authentication import SessionAuthentication 
from rest_framework.permissions import IsAuthenticated

# Try to import KokoroCardTTSService, but don't fail if kokoro/loguru is missing
try:
    from .services.kokoro_card_tts_service import KokoroCardTTSService
except ImportError:
    # If kokoro is not installed, create a dummy class
    class KokoroCardTTSService:
        def __init__(self, *args, **kwargs):
            raise ImportError("Kokoro or loguru is not installed. Please install it to use TTS features.")

from django.db.models.functions import Random
from django.db import transaction
COOKIE_NAME = 'fb_session'
COOKIE_AGE = 14*24*60*60

User = get_user_model()

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_metrics(request):
    """
    Return all simulator metrics.
    """
    #fetch query
    metrics = SimulatorMetric.objects.all().values('id', 'name')
    return Response(list(metrics))

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_simulator_tags(request):
    """
    Return all simulator tags.
    """
    #fetch query
    simulator_tags = SimulatorTag.objects.all().values('id', 'name')
    return Response(list(simulator_tags))

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_progress_statuses(request):
    """
    Return all possible progress status values for the progress status dropdown menu.
    """
    statuses = [
        {"value": ProgressStatus.NOT_STARTED, "label": "Not started"},
        {"value": ProgressStatus.IN_PROGRESS, "label": "In progress"},
        {"value": ProgressStatus.DONE, "label": "Done"},
    ]
    return Response(statuses)

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_simulator_levels(request):
    """
    Return all possible simulator level values for the simulator level dropdown menu.
    """
    levels = [
        {"value": SimulatorLevel.INTRO, "label": "Intro"},
        {"value": SimulatorLevel.CORE, "label": "Core"},
        {"value": SimulatorLevel.ADVANCED, "label": "Advanced"},
    ]
    return Response(levels)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_simulator_specific_tags(request, simulator_id: int):
    """
    Return all tags for a specific simulator :
    - simulator_id: id of the simulator for which we want to fetch the tags
    """
    try:
        # Fetch all tag ids associated with this simulator
        tag_ids = SimulatorContainsTag.objects.filter(simulator_id=simulator_id).values_list('simulator_tag_id', flat=True)

        # Fetch the tag details (id and name)
        tags = SimulatorTag.objects.filter(id__in=tag_ids).values('id', 'name')

        return Response({
            "simulator_id": simulator_id,
            "tags": list(tags)
        })
    except Exception as e:
        return Response({
            "error": f"Error fetching tags for simulator {simulator_id}: {str(e)}"
        }, status=404)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_simulator_specific_metrics(request, simulator_id: int):
    """
    Return all metrics for a specific simulator with their initial value of 50.
    This endpoint is useful to fetch metrics for a specific simulator to display them in the UI :
    - simulator_id: id of the simulator for which we want to fetch the metrics
    """
    try:
        # Fetch all metric ids associated with this simulator
        metric_ids = SimulatorContainsMetrics.objects.filter(simulator_id=simulator_id).values_list('metric_id', flat=True)

        # Fetch the metric details (id and name)
        metrics = SimulatorMetric.objects.filter(id__in=metric_ids).values('id', 'name')

        # Add initial value of 50 to each metric
        metrics_with_values = [
            {
                "id": metric['id'],
                "name": metric['name'],
                "initial_value": 50
            }
            for metric in metrics
        ]

        return Response({
            "simulator_id": simulator_id,
            "metrics": metrics_with_values
        })
    except Exception as e:
        return Response({
            "error": f"Error fetching metrics for simulator {simulator_id}: {str(e)}"
        }, status=404)

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_categories(request):
    """
    Return all module categories.
    """
    #fetch query
    categories = ModuleCategory.objects.all().values('id', 'title', 'description', 'created_at')
    return Response(list(categories))

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_modules(request):
    """
    Return all modules.
    """
    #fetch query
    modules = Module.objects.all().values('id', 'module_category_id', 'day_number', 'title', 'description', 'target_audience', 'estimated_duration', 'created_at')
    return Response(list(modules))

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_simulators(request):
    """
    Return all simulators.
    """
    #fetch query
    simulators = Simulator.objects.all()
    simulators_data = []

    for sim in simulators:
        #1. fetch the tag ids associated with the simulator from SimulatorContainsTag table
        tag_ids = SimulatorContainsTag.objects.filter(simulator_id=sim.id).values_list('simulator_tag_id', flat=True)

        #2. fetch the tag details (id and name) for these tag ids from SimulatorTag table
        tags = SimulatorTag.objects.filter(id__in=tag_ids).values('id', 'name')

        #3. construct the simulator data with its details and associated tags
        simulators_data.append({
            "id": sim.id,
            "title": sim.title,
            "description": sim.description,
            "level": sim.level,
            "localisation": sim.localisation,
            "estimated_duration": sim.estimated_duration,
            "created_at": sim.created_at,
            "tags": list(tags)  # On ajoute la liste des tags ici
        })

    return Response(simulators_data)

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_entity_cards(request, owner_type: str, owner_id: int):
    """
    Return all cards of a specific module or simulator depending on :
    - the owner_type (module or simulator)
    - owner_id (id of the module or simulator)
    """
    #filter by owner_type and owner_id
    cards = Card.objects.filter(owner_type=owner_type, owner_id=owner_id).order_by('card_order_index')

    cards_data = []
    for card in cards:
        cards_data.append({
            'id': card.id,
            'owner_type': card.owner_type,
            'owner_id': card.owner_id,
            'card_order_index': card.card_order_index,
            'title': card.title,
            'subtitle': card.subtitle,
            'end_text': card.end_text,
            'why_this_question': card.why_this_question,
        })

    #fetch query
    return Response(cards_data)

@api_view(['GET'])
@permission_classes([AllowAny]) #acces with no firebase or authenticate to test if the endpoint is working
def get_cards_full_content(request, card_id: int):
    """
    Return the complete content of a card with all its components based on :
    - card_id: id of the card to retrieve
    """
    try:
        card = Card.objects.get(id=card_id)
    except Card.DoesNotExist:
        return Response({"error": "Card not found"}, status=404)

    # Get components links of the card ordered by component_order_index
    links = CardContains.objects.filter(card_id=card.id).order_by('component_order_index')

    full_components = []

    # For each content link, get the component and its content
    for link in links:
        component_data = get_component_data(link.component_type, link.component_id)
        if component_data:
            component_data["order"] = link.component_order_index
            full_components.append(component_data)

    return Response(full_components)

def get_component_data(component_type: str, component_id: int):
    """
    Helper function to get the complete data of a component based :
     - component_type: type of the component (title, text, mcq, etc.)
     - component_id: id of the component in its respective table
    """
    data = {"type": component_type}

    try:
        if component_type == 'title':
            obj = ComponentTitle.objects.get(id=component_id)
            data["content"] = obj.content
        elif component_type == 'subtitle':
            obj = ComponentSubtitle.objects.get(id=component_id)
            data["content"] = obj.content
        elif component_type == 'text':
            obj = ComponentText.objects.get(id=component_id)
            data["content"] = obj.content
        elif component_type == 'quote':
            obj = ComponentQuote.objects.get(id=component_id)
            data["content"] = obj.content
            data["author"] = obj.author
        elif component_type == 'image':
            obj = ComponentImage.objects.get(id=component_id)
            data["url"] = obj.image_url
            data["alt"] = obj.image_alt
            data["description"] = obj.image_description
        elif component_type == 'video':
            obj = ComponentVideo.objects.get(id=component_id)
            data["url"] = obj.video_url
            data["duration"] = obj.video_duration_est
            data["alt"] = obj.video_alt
            data["description"] = obj.video_description
        elif component_type == 'mcq':
            obj = ComponentMCQ.objects.get(id=component_id)
            data["id"] = obj.id
            data["question"] = obj.question
            options = MCQOptions.objects.filter(mcq_id=component_id)
            data["options"] = [{"id": o.id, "text": o.option_text, "feedback": o.feedback} for o in options]
        elif component_type == 'open question':
            obj = ComponentOpenQuestion.objects.get(id=component_id)
            data["id"] = obj.id
            data["question"] = obj.question
            data["placeholder"] = obj.placeholder
        elif component_type == 'list':
            obj = ComponentList.objects.get(id=component_id)
            data["content"] = obj.content
        elif component_type == 'last message':
            obj = ComponentLastMessage.objects.get(id=component_id)
            data["content"] = obj.content

        return data
    except Exception:
        return None


@api_view(['GET'])
@permission_classes([AllowAny])
def get_entity_cards_full(request, owner_type: str, owner_id: int):
    """
    Return all cards of a specific module or simulator with their complete content and components based on :
    - owner_type (module or simulator)
    - owner_id (id of the module or simulator)
    """
    # Get all cards ordered by card_order_index
    cards = Card.objects.filter(
        owner_type=owner_type,
        owner_id=owner_id
    ).order_by('card_order_index')

    # If no cards found, return empty response
    if not cards.exists():
        return Response({
            "owner_type": owner_type,
            "owner_id": owner_id,
            "total_cards": 0,
            "cards": []
        })

    cards_data = []

    for card in cards:
        # Get all components for this card
        links = CardContains.objects.filter(
            card_id=card.id
        ).order_by('component_order_index')

        components = []
        for link in links:
            component_data = get_component_data(
                link.component_type,
                link.component_id
            )
            if component_data:
                component_data["order"] = link.component_order_index
                components.append(component_data)

        # Build card data with all components
        card_data = {
            "id": card.id,
            "card_order_index": card.card_order_index,
            "title": card.title,
            "subtitle": card.subtitle,
            "end_text": card.end_text,
            "why_this_question": card.why_this_question,
            "components": components
        }

        cards_data.append(card_data)

    return Response({
        "owner_type": owner_type,
        "owner_id": owner_id,
        "total_cards": len(cards_data),
        "cards": cards_data
    })

@api_view(['GET'])
@permission_classes([AllowAny])
def get_user_progress(request, user_id: int):
    """
    Returns the progress status for all modules and simulators for a specific user :
    - user_id: id of the user for which we want to fetch the progress
    """
    #we first fetch all existing progress records for the user to build a map of (owner_type, owner_id) -> status
    existing_progress = UserProgress.objects.filter(user_id=user_id)
    progress_map = {(p.owner_type, p.owner_id): p.status for p in existing_progress}

    #we also fetch all modules and simulators to return a complete list with default "Not started" status for those without progress record
    all_modules = Module.objects.all()
    all_simulators = Simulator.objects.all()

    full_progress_list = []

    #for each module and simulator, check if there's a recorded progress, if not default to "Not started"
    for m in all_modules:
        status = progress_map.get(('module', m.id), 'Not started')
        full_progress_list.append({
            'owner_type': 'module',
            'owner_id': m.id,
            'status': status
        })

    for s in all_simulators:
        status = progress_map.get(('simulator', s.id), 'Not started')
        full_progress_list.append({
            'owner_type': 'simulator',
            'owner_id': s.id,
            'status': status
        })

    return Response(full_progress_list)

@api_view(['POST'])
@permission_classes([AllowAny])
def update_user_progress(request):
    """
    Update or create a progress record for a user.
    """
    user_id = request.data.get('user_id')
    owner_type = request.data.get('owner_type')
    owner_id = request.data.get('owner_id')
    status = request.data.get('status')

    #update_or_create method is used to ensure that we have only one progress record per user + module/simulator combination :
    #check if a progress record already exists for the given user_id, owner_type and owner_id :
    #if exists, it updates the existing record with the new status and last_accessed_at timestamp
    #if not exists, it creates a new record with the provided data
    progress, created = UserProgress.objects.update_or_create(
        user_id=user_id,
        owner_type=owner_type,
        owner_id=owner_id,
        defaults={
            'status': status,
            'last_accessed_at': timezone.now()
        }
    )

    return Response({
        "message": "Progress updated!",
        "new_entry": created, #tells if a new line was created
        "current_status": progress.status
    })

@api_view(['POST'])
@permission_classes([AllowAny])
def save_open_question_response(request):
    """
    Saves or updates the user's written response to an open question.
    If the user has already answered this question, the response will be updated instead of creating a new entry.
    """
    user_id = request.data.get('user_id')
    open_question_id = request.data.get('open_question_id')
    answer_text = request.data.get('answer_text')

    # update_or_create ensures that we have only one response per user + open_question combination
    # If exists, it updates the answer_text; if not exists, it creates a new record
    response, created = UserResponseOpenQuestions.objects.update_or_create(
        user_id=user_id,
        open_question_id=open_question_id,
        defaults={
            'answer_text': answer_text
        }
    )

    return Response({
        "message": "Response to open question saved !" if created else "Response to open question updated !",
        "id": response.id,
        "linked_to_question": open_question_id,
        "is_new": created
    }, status=201 if created else 200)


@api_view(['POST'])
@permission_classes([AllowAny])
def save_mcq_response(request):
    """
    Saves the user's selected option for a multiple-choice question, returns the feedback for the selected option,
    and updates the user's scores (weights). If the user has already answered this question,
    it reverts the previous score before applying the new one.
    """
    try:
        user_id = request.data.get('user_id')
        selected_option_id = request.data.get('selected_option_id')

        with transaction.atomic():
            #fetch the new selected option
            new_option = MCQOptions.objects.get(id=selected_option_id)

            #check if the user has already answered this specific question (mcq_id)
            existing_response = UserResponseMCQ.objects.filter(
                user_id=user_id,
                selected_option__mcq_id=new_option.mcq_id
            ).first()

            if existing_response:
                #1. if a response exists, fetch weights of the OLD option to revert the score
                old_weights = MultipleChoicesOptionsWeights.objects.filter(
                    multiple_choices_options_id=existing_response.selected_option_id
                ).select_related('simulator_metric')

                # Create a dictionary to avoid duplicate processing
                old_weight_mapping = {}
                for ow in old_weights:
                    old_weight_mapping[ow.simulator_metric_id] = ow.weight

                # Revert each weight independently
                for ow in old_weights:
                    metric_id = ow.simulator_metric_id
                    weight_value = old_weight_mapping[metric_id]
                    user_score = UserScoreSimulator.objects.get(user_id=user_id, metric_id=metric_id)
                    old_value = user_score.score_value
                    user_score.score_value = max(0, min(100, user_score.score_value - weight_value))
                    user_score.save()

                #2. delete the old response record
                existing_response.delete()
            else:
                print(f"[MCQ INFO] No existing response for this question. This is a fresh start.")

            #save the new response
            UserResponseMCQ.objects.create(user_id=user_id, selected_option=new_option)

            #calculate new score based on the weights of the new selected option
            new_weights = MultipleChoicesOptionsWeights.objects.filter(
                multiple_choices_options_id=selected_option_id
            ).select_related('simulator_metric')
            updated_metrics = []

            # Create a dictionary to map metric_id -> weight for clarity and correctness
            weight_mapping = {}
            for nw in new_weights:
                weight_mapping[nw.simulator_metric_id] = nw.weight

            # Apply each weight independently to its corresponding metric
            for nw in new_weights:
                metric_id = nw.simulator_metric_id
                weight_value = weight_mapping[metric_id]

                user_score, created = UserScoreSimulator.objects.get_or_create(
                    user_id=user_id, metric_id=metric_id, defaults={'score_value': 50}
                )
                old_value = user_score.score_value
                user_score.score_value = max(0, min(100, user_score.score_value + weight_value))
                user_score.save()

                # Refresh from DB to ensure we have the latest value
                user_score.refresh_from_db()

                updated_metrics.append({"metric": nw.simulator_metric.name, "new_score": user_score.score_value})

            # Log de vérification du format
            response_data = {
                "message": "MCQ updated and scores adjusted",
                "feedback": new_option.feedback,
                "updated_metrics": updated_metrics
            }

            return Response(response_data)

    except MCQOptions.DoesNotExist:
        return Response({"error": "Option not found"}, status=404)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_daily_checkin_questions(request):
    """
    Returns exactly 3 daily check-in questions with their options and scores.

    Logic:
    1. Check if user has already answered questions today - if yes, return those questions
    2. If no, randomly select 3 different metrics and 1 question per metric
    3. Ensure no duplicate metrics in a single day
    """
    user_id = request.query_params.get('user_id')

    if not user_id:
        return Response({
            "error": "user_id parameter is required"
        }, status=400)

    # Define the start of today
    today_start = timezone.now().replace(hour=0, minute=0, second=0, microsecond=0)
    today_end = today_start.replace(hour=23, minute=59, second=59, microsecond=999999)

    # Step 1: Check if user already has responses for today
    existing_responses = UserDailyCheckinResponse.objects.filter(
        user_id=user_id,
        created_at__gte=today_start,
        created_at__lte=today_end
    ).select_related('option__question')

    if existing_responses.exists():
        # User already answered today - return those questions
        questions_seen = set()
        output = []

        for response in existing_responses:
            question = response.option.question
            if question.id not in questions_seen:
                questions_seen.add(question.id)
                options = DailyCheckinOption.objects.filter(question_id=question.id)
                output.append({
                    "id": question.id,
                    "question_text": question.question_text,
                    "metric_id": question.metric_id,
                    "options": [
                        {"id": o.id, "text": o.option_text, "score": o.score_value}
                        for o in options
                    ]
                })

        return Response({
            "questions": output,
            "is_today_response": True,
            "message": "Questions already answered today"
        })

    # Step 2: No responses yet today - draw 3 random metrics
    all_metrics = list(DailyCheckinMetric.objects.all().values_list('id', flat=True))

    if len(all_metrics) < 3:
        return Response({
            "error": f"Not enough metrics available (need at least 3, have {len(all_metrics)})"
        }, status=400)

    # Randomly select 3 different metrics
    selected_metric_ids = random.sample(all_metrics, 3)

    # Step 3: For each metric, randomly select 1 question
    output = []
    for metric_id in selected_metric_ids:
        questions = DailyCheckinQuestion.objects.filter(metric_id=metric_id)

        if not questions.exists():
            return Response({
                "error": f"Metric {metric_id} has no questions associated"
            }, status=400)

        # Randomly select one question from this metric
        selected_question = random.choice(list(questions))

        # Get options for this question
        options = DailyCheckinOption.objects.filter(question_id=selected_question.id)

        output.append({
            "id": selected_question.id,
            "question_text": selected_question.question_text,
            "metric_id": metric_id,
            "options": [
                {"id": o.id, "text": o.option_text, "score": o.score_value}
                for o in options
            ]
        })

    return Response({
        "questions": output,
        "is_today_response": False,
        "message": "New questions for today"
    })


@api_view(['POST'])
@permission_classes([AllowAny])
@transaction.atomic
def submit_daily_checkin(request):
    """
    Saves the user's daily check-in responses, calculates the total score, and saves the overall power level for the day.
    """
    user_id = request.data.get('user_id')
    option_ids = request.data.get('option_ids')

    #1. define the start of the day to filter existing responses and power level for today
    today_start = timezone.now().replace(hour=0, minute=0, second=0, microsecond=0)

    #2. delete existing responses of the user for today to avoid duplicates if the user is updating their check-in during the day
    UserDailyCheckinResponse.objects.filter(
        user_id=user_id,
        created_at__gte=today_start
    ).delete()

    #3. delete existing power level record of the user for today to avoid duplicates and keep only the latest submitted check-in as the valid one for the day
    UserDailyPowerCheck.objects.filter(
        user_id=user_id,
        created_at__gte=today_start
    ).delete()


    total_score = 0

    #1. save each selected option and calculate total score
    for oid in option_ids:
        option = DailyCheckinOption.objects.get(id=oid)
        total_score += option.score_value

        UserDailyCheckinResponse.objects.create(
            user_id=user_id,
            option_id=oid
        )
    #2. save the total score as the user's power level for the day
    UserDailyPowerCheck.objects.create(
        user_id=user_id,
        total_power_level=total_score
    )

    return Response({
        "message": "Power Check saved !",
        "power_level": total_score,
        "status": "Stable" if total_score >= 50 else "Low"
    }, status=201)


@api_view(['GET'])
@permission_classes([AllowAny])
def get_simulator_results(request, user_id: int, simulator_id: int):
    """
    Analyzes the user's scores for the metrics related to a specific simulator and returns feedback :
    - user_id: id of the user for which we want to fetch the results
    - simulator_id: id of the simulator for which we want to fetch the results
    """
    #1. fetch all metric ids related to the simulator from SimulatorContainsMetrics table
    simulator_metrics = SimulatorContainsMetrics.objects.filter(simulator_id=simulator_id).values_list('metric_id',
                                                                                                      flat=True)

    results = []

    for metric_id in simulator_metrics:
        #2. fetch the user's score for the metric from UserScoreSimulator table, if no score found, default to 50
        user_score_obj = UserScoreSimulator.objects.filter(user_id=user_id, metric_id=metric_id).first()
        score = user_score_obj.score_value if user_score_obj else 50  # 50 par défaut

        #3. find the feedback tier for the score in SimulatorFeedbackTiers table based on the simulator_id, metric_id and score range (min_score <= score <= max_score)
        tier = SimulatorFeedbackTiers.objects.filter(
            simulator_id=simulator_id,
            metric_id=metric_id,
            min_score__lte=score,
            max_score__gte=score
        ).first()

        if tier:
            results.append({
                "metric_name": tier.metric.name,
                "score": score,
                "strength": tier.strength_result,
                "risk": tier.risk_result,
                "practice": tier.micro_practice,
                "recommendation": {
                    "module_id": tier.recommended_module_id,
                    "reason": tier.recommendation_reason
                }
            })

    return Response({
        "user_id": user_id,
        "simulator_id": simulator_id,
        "feedbacks": results
    })


@api_view(['POST'])
@permission_classes([AllowAny])
def reset_simulator_scores(request, user_id: int, simulator_id: int):
    """
    Resets all metric scores for a user on a specific simulator to 50 AND deletes all MCQ responses
    (usually called when restarting/clicking on a simulator) :
    - user_id: id of the user for which we want to reset the scores
    - simulator_id: id of the simulator for which we want to reset the scores
    """
    try:
        # Get all metrics for this simulator
        simulator_metrics = SimulatorContainsMetrics.objects.filter(
            simulator_id=simulator_id
        ).values_list('metric_id', flat=True)

        # Step 1: Get all MCQ component_ids for this simulator to delete user responses
        # Find all cards for this simulator
        all_cards_in_simulator = Card.objects.filter(
            owner_type='simulator',
            owner_id=simulator_id
        ).values_list('id', flat=True)

        # Find all MCQ component_ids in those cards
        all_mcq_component_ids = CardContains.objects.filter(
            card_id__in=all_cards_in_simulator,
            component_type='mcq'
        ).values_list('component_id', flat=True)

        # Delete all MCQ responses for this user in this simulator
        deleted_responses = UserResponseMCQ.objects.filter(
            user_id=user_id,
            selected_option__mcq_id__in=all_mcq_component_ids
        ).delete()

        # Step 2: Reset each metric score to 50
        for metric_id in simulator_metrics:
            # First, delete all existing records for this user+metric combination to handle duplicates
            UserScoreSimulator.objects.filter(
                user_id=user_id,
                metric_id=metric_id
            ).delete()

            # Then create a fresh record with score 50
            user_score = UserScoreSimulator.objects.create(
                user_id=user_id,
                metric_id=metric_id,
                score_value=50
            )

        return Response({
            "success": True,
            "message": f"Reset complete: {len(simulator_metrics)} metric scores reset to 50 and {deleted_responses[0]} MCQ responses deleted",
            "metrics_count": len(simulator_metrics),
            "responses_deleted": deleted_responses[0],
            "user_id": user_id,
            "simulator_id": simulator_id
        }, status=200)

    except Exception as e:
        print(f"[RESET ERROR] {str(e)}")
        import traceback
        traceback.print_exc()
        return Response({
            "success": False,
            "error": f"Error resetting simulator scores: {str(e)}"
        }, status=400)


@api_view(['GET'])
@permission_classes([AllowAny])
def get_story_tags(request):
    """
    Fetch all user story tags.
    """
    tags = UserStoryTag.objects.all()
    data = [{"id": tag.id, "name": tag.name} for tag in tags]
    return Response(data)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_pending_stories(request):
    """
    Fetch all user stories awaiting moderation (is_published=False).
    This endpoint is for administrators/moderators.
    """
    #fetch stories ordered by most recent, showing only non-published ones
    stories = UserStory.objects.filter(is_published=False).order_by('-created_at')

    output = []

    for story in stories:
        #handling tags
        tag_links = StoryContainsTag.objects.filter(story=story)
        tags = [link.story_tag.name for link in tag_links]

        #construction of the output for each story with all its details
        output.append({
            "id": story.id,
            "user_id": story.user_id,
            "author": story.author_name,
            "localisation": story.localisation,
            "category": {
                "id": story.category.id if story.category else None,
                "title": story.category.title if story.category else "General"
            },
            "content": story.content,
            "is_published": story.is_published,
            "created_at": story.created_at,
            "tags": tags
        })

    return Response(output)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_all_stories(request):
    """
    Fetch all published user stories with their details, reactions and tags. Allows filtering by :
    - category_id : for category-based filtering of stories -> I Dare,...
    - user_id : for filtering personal stories
    - viewer_id : to check if the viewer has reacted to the story or not and the type of their reaction (relatable, support, powerful, inspiring)
    """
    #fetch query params for filters
    category_id = request.query_params.get('category_id')
    filter_user_id = request.query_params.get('user_id')
    viewer_id = request.query_params.get('viewer_id')

    #fetch stories ordered by most recent - only published stories
    stories = UserStory.objects.filter(is_published=True).order_by('-created_at')

    #filters
    if category_id:
        stories = stories.filter(category_id=category_id)

    if filter_user_id:
        stories = stories.filter(user_id=filter_user_id)

    output = []

    for story in stories:
        #handle reactions for the story : count of each reaction type and if the viewer has reacted or not and the type of their reaction
        reactions = UserStoryReaction.objects.filter(story=story)
        counts = {
            "relatable": reactions.filter(reaction_type='relatable').count(),
            "support": reactions.filter(reaction_type='support').count(),
            "powerful": reactions.filter(reaction_type='powerful').count(),
            "inspiring": reactions.filter(reaction_type='inspiring').count(),
        }

        #check if the viewer has reacted and get the type of their reaction if exists
        my_reaction = None
        if viewer_id:
            user_react = reactions.filter(user_id=viewer_id).first()
            if user_react:
                my_reaction = user_react.reaction_type

        #handling tags
        tag_links = StoryContainsTag.objects.filter(story=story)
        tags = [link.story_tag.name for link in tag_links]

        #construvtion of the output for each story with all its details, reactions and tags
        output.append({
            "id": story.id,
            "author": story.author_name,
            "localisation": story.localisation,
            "category": {
                "id": story.category.id if story.category else None,
                "title": story.category.title if story.category else "General"
            },
            "content": story.content,
            "is_published": story.is_published,
            "created_at": story.created_at,
            "reactions_count": counts,
            "user_has_reacted": my_reaction,
            "tags": tags
        })

    return Response(output)


@api_view(['POST'])
@permission_classes([AllowAny])
def create_story(request):
    """
    Create a user story and link it to existing tags.
    Only one story can be created per user per day.
    The operation is atomic, if any part fails (story creation or linking tags), the whole transaction will be rolled back to maintain data integrity.
    """
    data = request.data
    user_id = data.get('user_id')

    try:
        # Get current time and today's date range in the configured timezone
        now = timezone.now()
        today_date = now.date()

        # Get all stories for this user and check if any were created today
        all_stories_today = UserStory.objects.filter(user_id=user_id)

        # Check each story's date in the configured timezone
        for story in all_stories_today:
            story_date = story.created_at.astimezone(timezone.get_current_timezone()).date()
            if story_date == today_date:
                return Response(
                    {"error": "You can only create one story per day. Please try again tomorrow."},
                    status=429  # 429 Too Many Requests
                )

        with transaction.atomic():
            #1. create the story with the provided data and set is_published to False by default
            story = UserStory.objects.create(
                user_id=user_id,
                author_name=data.get('author_name', 'Anonymous'),
                category_id=data.get('category_id'),
                localisation=data.get('localisation'),
                content=data.get('content'),
                is_published=False  # Stories are NOT published by default (await moderation)
            )

            #2. link the story to the provided tags if any
            tag_ids = data.get('tags', [])  # ex: [1, 3]
            for t_id in tag_ids:
                if UserStoryTag.objects.filter(id=t_id).exists():
                    StoryContainsTag.objects.create(
                        story=story,
                        story_tag_id=t_id
                    )

        return Response({"message": "Story saved and awaiting moderation!", "story_id": story.id, "is_published": False}, status=201)
    except Exception as e:
        return Response({"error": str(e)}, status=400)


@api_view(['DELETE'])
@permission_classes([AllowAny])
def delete_story(request, story_id):
    """
    Delete a user story if the requester is the author of the story based on :
    - story_id: id of the story to delete
    """
    try:
        #1. fetch the story to delete
        story = UserStory.objects.get(id=story_id)

        #2. check if the requester is the author of the story by comparing the user_id in the query params with the user_id of the story
        request_user_id = request.query_params.get('user_id')

        if request_user_id and int(request_user_id) != story.user_id:
            return Response(
                {"error": "You are not authorized to delete this story."},
                status=403
            )

        #3. handle delete
        story.delete()
        return Response({"message": "Story deleted !"}, status=200)

    except UserStory.DoesNotExist:
        return Response({"error": "Story not found !"}, status=404)

@api_view(['PATCH'])
@permission_classes([AllowAny])
def moderate_story(request, story_id):
    """
    Moderate a user story - approve (publish) or reject it based on :
    - story_id: id of the story to moderate
    """
    try:
        story = UserStory.objects.get(id=story_id)
        is_published = request.data.get('is_published')

        if is_published is None:
            return Response(
                {"error": "is_published parameter is required"},
                status=400
            )

        story.is_published = bool(is_published)
        story.save()

        status_text = "published" if story.is_published else "rejected"
        return Response(
            {"message": f"Story {status_text}!", "is_published": story.is_published},
            status=200
        )

    except UserStory.DoesNotExist:
        return Response({"error": "Story not found !"}, status=404)
    except Exception as e:
        return Response({"error": str(e)}, status=400)

@api_view(['POST'])
@permission_classes([AllowAny])
def toggle_story_reaction(request):
    """
    Handle the toggling of a user's reaction to a story.
    """
    story_id = request.data.get('story_id')
    user_id = request.data.get('user_id')
    reaction_type = request.data.get('reaction_type')

    try:
        #1. check if the reaction already exists for the user and story
        existing_reaction = UserStoryReaction.objects.filter(
            story_id=story_id,
            user_id=user_id
        ).first()

        if existing_reaction:
            if existing_reaction.reaction_type == reaction_type:
                #if user taps the same reaction again, we consider that they want to remove their reaction, so we delete the existing reaction
                existing_reaction.delete()
                return Response({"message": "reaction deleted", "action": "deleted"}, status=200)
            else:
                #if user taps a different reaction, we update the existing reaction with the new type
                existing_reaction.reaction_type = reaction_type
                existing_reaction.save()
                return Response({"message": "reaction updated", "action": "updated"}, status=200)
        else:
            #if no existing reaction, we create a new one with the provided type
            UserStoryReaction.objects.create(
                story_id=story_id,
                user_id=user_id,
                reaction_type=reaction_type
            )
            return Response({"message": "reaction saved", "action": "created"}, status=201)

    except Exception as e:
        return Response({"error": str(e)}, status=400)

@api_view(['POST'])
@permission_classes([AllowAny])
def generate_audio(request, owner_type: str, owner_id: int):
    """
    Generate audio for cards using Kokoro TTS :
    - owner_type: type of the owner of the cards (card, module, simulator)
    - owner_id: id of the owner (card_id, module_id, simulator_id)
    - force: if true, delete old audio and regenerate (useful for updates)
    """
    try:
        voice = request.data.get('voice', 'af_heart')
        speed = float(request.data.get('speed', 0.9))
        force = request.data.get('force', False) in [True, 'true', '1', 1]

        # Validate owner_type
        if owner_type not in ['card', 'module', 'simulator']:
            return Response(
                {'error': f'Invalid owner_type: {owner_type}. Must be "card", "module", or "simulator"'},
                status=400
            )

        # If force is True, delete old audio files
        if force:
            audio_dir = os.path.join(settings.MEDIA_ROOT, 'audios')
            if owner_type == 'card':
                # Delete audio for this specific card
                possible_files = [
                    f for f in os.listdir(audio_dir) if f.startswith(f'card_{owner_id}_') and f.endswith('.wav')
                ]
                for f in possible_files:
                    try:
                        os.remove(os.path.join(audio_dir, f))
                        print(f"Deleted old audio: {f}")
                    except Exception as e:
                        print(f"Could not delete {f}: {e}")
            else:
                # Delete audios for all cards of this module/simulator
                possible_files = [
                    f for f in os.listdir(audio_dir) if f'{owner_type}_{owner_id}' in f and f.endswith('.wav')
                ]
                for f in possible_files:
                    try:
                        os.remove(os.path.join(audio_dir, f))
                        print(f"Deleted old audio: {f}")
                    except Exception as e:
                        print(f"Could not delete {f}: {e}")

        #initialize Kokoro service
        tts_service = KokoroCardTTSService(lang_code='a', voice=voice, speed=speed)

        # ALWAYS exclude feedback from MCQ options (never read feedback in audio)
        exclude_feedback = True

        #generate audio based on owner_type
        if owner_type == 'card':
            result = tts_service.generate_audio_for_single_card(owner_id, exclude_feedback=exclude_feedback)
        else:
            result = tts_service.generate_audio_for_owner(owner_type, owner_id, exclude_feedback=exclude_feedback)

        return Response(result)

    except Exception as e:
        return Response(
            {'error': f'Error generating audio: {str(e)}'},
            status=500
        )


@api_view(['GET'])
@permission_classes([AllowAny])
def fetch_audio(request, owner_type: str, owner_id: int):
    """
    Fetch pre-generated audio file for a card/simulator/module.
    Audio files are stored in: media/audios/{owner_type}_{owner_id}_{context}.wav :
    - owner_type: type of the owner of the cards (card, module, simulator)
    - owner_id: id of the owner (card_id, module_id, simulator_id)
    """
    try:
        # Construct possible file paths based on owner_type and owner_id
        audio_dir = os.path.join(settings.MEDIA_ROOT, 'audios')

        if owner_type == 'card':
            # Try to find the audio file for this card
            # Format: card_{id}_module_{module_id}.wav or card_{id}_simulator_{sim_id}.wav
            possible_files = [
                f for f in os.listdir(audio_dir)
                if f.startswith(f'card_{owner_id}_') and f.endswith('.wav')
            ]

            if possible_files:
                # Use the first match found
                audio_filename = possible_files[0]
            else:
                return Response(
                    {'error': f'No audio file found for card {owner_id}'},
                    status=404
                )

        elif owner_type in ['module', 'simulator']:
            # Similar logic for modules and simulators
            possible_files = [
                f for f in os.listdir(audio_dir)
                if f'{owner_type}_{owner_id}' in f and f.endswith('.wav')
            ]

            if possible_files:
                audio_filename = possible_files[0]
            else:
                return Response(
                    {'error': f'No audio file found for {owner_type} {owner_id}'},
                    status=404
                )
        else:
            return Response(
                {'error': f'Invalid owner_type: {owner_type}'},
                status=400
            )

        audio_path = os.path.join(audio_dir, audio_filename)

        # Serve the file directly to avoid CORS issues and ensure compatibility
        if os.path.exists(audio_path):
            return FileResponse(open(audio_path, 'rb'), content_type='audio/wav')
        else:
            return Response(
                {'error': f'Audio file not found at {audio_path}'},
                status=404
            )

    except Exception as e:
        return Response(
            {'error': f'Error fetching audio: {str(e)}'},
            status=500
        )


from urllib.parse import quote
import json
from django.http import JsonResponse, HttpResponseBadRequest, HttpResponseForbidden

@login_required
def session_login(request):
    app = request.GET.get("redirect")
    if not app:
        return HttpResponseBadRequest("missing redirect")

    u = request.user
    refresh = RefreshToken.for_user(u)
    data = {
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "user": {
            "id": u.id,
            "email": u.email,
            "username": u.get_username(),
            "first_name": getattr(u, "first_name", "") or "",
            "last_name": getattr(u, "last_name", "") or "",
        },
    }

    payload = quote(json.dumps(data))
    sep = "&" if "?" in app else "?"
    return HttpResponse(
        f"""<!doctype html><meta charset="utf-8">
        <script>
          location.replace("{app}{sep}session={payload}");
        </script>"""
    )

@ensure_csrf_cookie
def csrf(request):
    # Access request to avoid unused parameter warning
    _ = request
    return HttpResponse(status=204)


@api_view(["GET"])
@authentication_classes([JWTAuthentication, SessionAuthentication])
@permission_classes([IsAuthenticated])
def me(request):
    u = request.user
    # 1) redirect query geldiyse SPA'ya dön
    target = request.GET.get("redirect")
    if target:
        # güvenlik için en basit whitelisting (opsiyonel)
        # izin verilenler dışı gelirse ignore edebilirsin
        html = f"""<!doctype html><meta charset="utf-8">
        <script>
          window.location = "{escape(target)}";
        </script>"""
        return HttpResponse(html)

    # 2) normal JSON cevabı
    return JsonResponse({
        "id": u.id,
        "email": u.email,
        "username": u.get_username(),
        "first_name": getattr(u, "first_name", "") or "",
        "last_name": getattr(u, "last_name", "") or "",
    })
    

@api_view(['POST'])
def logout(request):
    try:
        u = request.user
        if getattr(u, 'firebase_uid', None):
            fb_auth.revoke_refresh_tokens(u.firebase_uid)
    except Exception:
        pass
    resp = Response({'ok': True})
    resp.delete_cookie(COOKIE_NAME)
    return resp

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def profile_by_user(request, user_id: int):
    from django.db import connection
    with connection.cursor() as c:
        c.execute(
            "SELECT id, fk_user_id, username, name, lastname, bio, avatar_url, "
            "date_of_birth, country, city, language, is_visible, "
            "onboarding_completed, notification_enabled, created_at, updated_at "
            "FROM user_profile WHERE fk_user_id = %s",
            [user_id],
        )
        row = c.fetchone()

    if not row:
        return JsonResponse({"error": "profile not found for this user"}, status=404)

    data = {
        "id": row[0],
        "fk_user_id": row[1],
        "username": row[2],
        "name": row[3],
        "lastname": row[4],
        "bio": row[5],
        "avatar_url": row[6],
        "date_of_birth": str(row[7]) if row[7] else None,
        "country": row[8],
        "city": row[9],
        "language": row[10],
        "is_visible": bool(row[11]),
        "onboarding_completed": bool(row[12]),
        "notification_enabled": bool(row[13]),
        "created_at": str(row[14]) if row[14] else None,
        "updated_at": str(row[15]) if row[15] else None,
    }
    return JsonResponse(data)

#may be utilized for elevateher ?
'''
def _ok(data):
    return JsonResponse({"results": data})


def _is_any_blocked(a_profile_id: int, b_profile_id: int) -> bool:
    return PrivateMessageBlocked.objects.filter(
        Q(fk_blocker_profile=a_profile_id, fk_blocked_profile=b_profile_id) |
        Q(fk_blocker_profile=b_profile_id, fk_blocked_profile=a_profile_id)
    ).exists()

@login_required
def session_login(request):
    """
    Allauth dönüşünden sonra (kullanıcı session’ı var),
    JWT üret ve frontend’e yönlendir.
    redirect paramı SPA adresi (örn: http://localhost:8080/#/afterlogin)
    """
    app = request.GET.get("redirect")
    if not app:
        return HttpResponseBadRequest("missing redirect")

    u = request.user
    refresh = RefreshToken.for_user(u)
    data = {
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "user": {
            "id": u.id,
            "email": u.email,
            "username": u.get_username(),
            "first_name": getattr(u, "first_name", "") or "",
            "last_name": getattr(u, "last_name", "") or "",
        },
    }

    # JSON’u URL encode et
    payload = quote(json.dumps(data))

    # SPA hash router kullandığın için paramı hash’ten SONRA taşıyacağız:
    # http://localhost:8080/#/afterlogin?session=<...>
    sep = "&" if "?" in app else "?"
    return HttpResponse(
        f"""<!doctype html><meta charset="utf-8">
        <script>
          // Tam ekran yönlendirme; CORS yok, cookie geldi.
          location.replace("{app}{sep}session={payload}");
        </script>"""
    )



# api/auth.py (senin me view’in neredeyse)







# @api_view(['GET'])
# @permission_classes([AllowAny])
# @authentication_classes([])   # <— bypass all auth backends
# def test_view(request):
#     # basit test
#     return Response({"status": "ok", "message": "test"})

# api/views.py
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from .models import Profile

from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from django.utils import timezone
from .models import Profile
from urllib.parse import quote
import json

@api_view(['GET'])
def protected_view(request):
    # auth gerektirir (global DRF IsAuthenticated yüzünden)
    u = request.user
    return Response({
        "status": "ok",
        "who": u.email or u.username,
        "uid": getattr(u, "firebase_uid", None)
    })




from django.http import JsonResponse, HttpResponseBadRequest
from django.db.models import Q, Exists, OuterRef, BooleanField, Value, Count, Prefetch

from api.models import (
    Profile, Follow,
)

@api_view(["GET"])
def profile_detail(request, pk: int):
    try:
        p = Profile.objects.get(pk=pk)
    except Profile.DoesNotExist:
        return HttpResponseBadRequest("invalid profile id")

    # ----- Followers -----
    follower_rows = Follow.objects.filter(fk_followed_pr=p.id)
    follower_ids = list({row.fk_following_pr for row in follower_rows})  # distinct
    follower_profiles = Profile.objects.filter(id__in=follower_ids)

    followers = []
    for fp in follower_profiles:
        full_name = f"{fp.name or ''} {fp.lastname or ''}".strip()
        followers.append({
            "id": fp.id,
            "username": fp.username,
            "name": fp.name,
            "lastname": fp.lastname,
            "full_name": full_name,
            "p_photo_link": fp.p_photo_link or "",
        })

    # ----- Ana profil datası + ekstra alanlar -----
    data = {
        "id": p.id,
        "username": p.username,
        "name": p.name,
        "lastname": p.lastname,
        "bio": p.bio,
        "p_photo_link": p.p_photo_link,
        "nofviews": p.nofviews,
        "is_visible": p.is_visible,
        "showmail": p.showmail,
        "lastupdate": p.lastupdate,
        "fk_province": p.fk_province,
        "fk_user_id": p.fk_user_id,

        # follower bilgisi
        "follower_count": len(followers),
        "followers": followers,
    }

    return JsonResponse(data)


@api_view(["PUT"])
def profile_update(request, pk: int):
    try:
        p = Profile.objects.get(pk=pk)
    except Profile.DoesNotExist:
        return HttpResponseBadRequest("invalid profile id")

    body = request.data

    # Güncellenebilir alanlar
    fields = [
        "username",
        "name",
        "lastname",
        "bio",
        "p_photo_link",
        "nofviews",
        "is_visible",
        "showmail",
        "fk_province",
    ]

    for f in fields:
        if f in body:
            setattr(p, f, body[f])

    # lastupdate'i sistem güncellesin
    p.lastupdate = timezone.now()

    p.save(update_fields=fields + ["lastupdate"])

    return JsonResponse({"status": "ok", "updated_id": p.id})






import os
import uuid
from django.conf import settings
from rest_framework.decorators import parser_classes
from rest_framework.parsers import MultiPartParser, FormParser
from django.utils.text import slugify

@api_view(["POST"])
@parser_classes([MultiPartParser, FormParser])
@login_required
def upload_profile_photo(request):
    """
    Gönderilen profil fotoğrafını kaydeder, URL döndürür.
    """

    file = request.FILES.get("file")
    if not file:
        return JsonResponse({"error": "no file uploaded"}, status=400)

    # pp klasörü (profile photos)
    upload_dir = os.path.join(settings.MEDIA_ROOT, "bpp")
    os.makedirs(upload_dir, exist_ok=True)

    ext = (file.name.split(".")[-1] or "").lower()
    unique_name = f"logo_{uuid.uuid4().hex}.{ext}"

    saved_path = os.path.join(upload_dir, unique_name)

    with open(saved_path, "wb+") as dest:
        for chunk in file.chunks():
            dest.write(chunk)

    file_url = settings.MEDIA_URL + "bpp/" + unique_name

    return JsonResponse({"url": file_url})


from django.db.models import Exists, OuterRef, BooleanField, Value, Count, Prefetch
from rest_framework.decorators import api_view
from django.utils import timezone

def _get_my_profile(request):
    if not request.user.is_authenticated:
        return None
    return Profile.objects.filter(fk_user_id=request.user.id).first()

def _get_my_profile_id(request):
    if not request.user.is_authenticated:
        return None
    p = Profile.objects.filter(fk_user_id=request.user.id).only("id").first()
    return p.id if p else None

from django.db.models import Exists, OuterRef, BooleanField, Value, Count, Prefetch

from rest_framework.decorators import api_view
from django.db.models import Q
from django.db import transaction
from api.services.notifications import create_notification
from api.models import Notification

from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view, permission_classes
from django.utils import timezone

from django.db.models import Subquery, OuterRef
from api.models import Profile, Notification

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def notifications_latest(request):
    """
    Return last 50 notifications + sender profile info.
    """
    # Login olan user’ın profili
    profile = Profile.objects.filter(fk_user_id=request.user.id).first()
    if not profile:
        return JsonResponse({"results": []})

    # Gönderen profil bilgilerini almak için subquery
    sender_qs = Profile.objects.filter(id=OuterRef("fk_by_profile"))

    notifs = (
        Notification.objects
        .filter(fk_for_profile=profile.id)
        .annotate(
            sender_id=Subquery(sender_qs.values("id")[:1]),
            sender_username=Subquery(sender_qs.values("username")[:1]),
            sender_name=Subquery(sender_qs.values("name")[:1]),
            sender_lastname=Subquery(sender_qs.values("lastname")[:1]),
            sender_photo=Subquery(sender_qs.values("p_photo_link")[:1]),
        )
        .order_by("-id")[:50]
        .values(
            "id",
            "type",
            "created_on",
            "is_seen",
            "nofview",
            "fk_for_profile",
            "fk_by_profile",
            "fk_post",

            # eklenenler
            "sender_id",
            "sender_username",
            "sender_name",
            "sender_lastname",
            "sender_photo",
        )
    )

    return JsonResponse({"results": list(notifs)}, safe=False)



@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def notification_mark_seen(request, pk: int):
    """
    PUT /notifications/<pk>/seen
    Marks a notification as seen (is_seen = True)
    Only if it belongs to the logged-in user's profile.
    """
    # Kullanıcının profilini bul
    profile = Profile.objects.filter(fk_user_id=request.user.id).first()
    if not profile:
        return JsonResponse({"error": "profile not found"}, status=400)

    # Bildirimi getir
    notif = Notification.objects.filter(pk=pk).first()
    if not notif:
        return JsonResponse({"error": "invalid notification id"}, status=400)

    # Başkasının bildirimi ise izin verme
    if notif.fk_for_profile != profile.id:
        return JsonResponse({"error": "forbidden"}, status=403)

    # Update
    notif.is_seen = True
    notif.save(update_fields=["is_seen"])

    return JsonResponse({
        "status": "ok",
        "id": notif.id,
        "is_seen": notif.is_seen,
    })
    



@api_view(["POST"])
@permission_classes([IsAuthenticated])
def send_message(request, to_profile_id: int):
    me = _get_my_profile(request)
    if not me:
        return HttpResponseBadRequest("profile not found for this user")

    try:
        to_profile = Profile.objects.get(pk=to_profile_id)
    except Profile.DoesNotExist:
        return HttpResponseBadRequest("target profile not found")

    # BLOCK CHECK (iki yönlü)
    if _is_any_blocked(me.id, to_profile.id):
        return HttpResponseForbidden("messaging is blocked between these users")

    content = (request.data.get("content") or "").strip()
    if not content:
        return HttpResponseBadRequest("content is required")

    msg_type = int(request.data.get("type") or PrivateMessage.TYPE_NORMAL)

    pm = PrivateMessage.objects.create(
        pm_date=timezone.now(),
        is_viewed=False,
        type=msg_type,
        content=content,
        fk_from_profile=me.id,
        fk_to_profile=to_profile.id,
    )

    # konuşma gizliyse, yeni mesaj atınca tekrar görünür olsun (bence doğru UX)
    PrivateMessageHiddenConversation.objects.filter(
        Q(fk_owner_profile=me.id, fk_other_profile=to_profile.id) |
        Q(fk_owner_profile=to_profile.id, fk_other_profile=me.id)
    ).delete()

    return JsonResponse({
        "status": "ok",
        "id": pm.id,
        "from_profile": pm.fk_from_profile,
        "to_profile": pm.fk_to_profile,
        "pm_date": pm.pm_date,
        "content": pm.content,
        "type": pm.type,
        "is_viewed": pm.is_viewed,
    })
    
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def my_conversations(request):
    me = _get_my_profile(request)
    if not me:
        return JsonResponse({"results": []})

    # benim blockladıklarım + beni blocklayanlar (iki yönlü net)
    blocked_by_me = set(
        PrivateMessageBlocked.objects.filter(fk_blocker_profile=me.id)
        .values_list("fk_blocked_profile", flat=True)
    )
    blocked_me = set(
        PrivateMessageBlocked.objects.filter(fk_blocked_profile=me.id)
        .values_list("fk_blocker_profile", flat=True)
    )
    blocked_any = blocked_by_me | blocked_me

    hidden_set = set(
        PrivateMessageHiddenConversation.objects.filter(fk_owner_profile=me.id)
        .values_list("fk_other_profile", flat=True)
    )

    qs = PrivateMessage.objects.filter(
        Q(fk_from_profile=me.id) | Q(fk_to_profile=me.id)
    ).order_by("-pm_date", "-id")

    if not qs.exists():
        return JsonResponse({"results": []})

    conversations = {}
    for m in qs:
        a = min(m.fk_from_profile, m.fk_to_profile)
        b = max(m.fk_from_profile, m.fk_to_profile)
        key = (a, b)
        if key not in conversations:
            conversations[key] = m

    other_ids = set()
    for (a, b) in conversations.keys():
        other_id = a if a != me.id else b
        # hidden veya blocked ise atla
        if other_id in hidden_set:
            continue
        if other_id in blocked_any:
            continue
        other_ids.add(other_id)

    other_profiles = {p.id: p for p in Profile.objects.filter(id__in=other_ids)}

    results = []
    for (a, b), msg in conversations.items():
        other_id = a if a != me.id else b
        if other_id not in other_profiles:
            continue

        op = other_profiles[other_id]

        has_unread = PrivateMessage.objects.filter(
            fk_from_profile=other_id,
            fk_to_profile=me.id,
            is_viewed=False,
        ).exists()

        full_name = f"{op.name or ''} {op.lastname or ''}".strip()

        results.append({
            "other_profile": {
                "id": op.id,
                "username": op.username,
                "name": op.name,
                "lastname": op.lastname,
                "full_name": full_name,
                "p_photo_link": op.p_photo_link or "",
            },
            "last_message": {
                "id": msg.id,
                "from_profile": msg.fk_from_profile,
                "to_profile": msg.fk_to_profile,
                "content": msg.content,
                "pm_date": msg.pm_date,
                "is_viewed": msg.is_viewed,
                "type": msg.type,
                "is_from_me": (msg.fk_from_profile == me.id),
            },
            "has_unread": has_unread,
        })

    results.sort(key=lambda r: r["last_message"]["pm_date"], reverse=True)
    return JsonResponse({"results": results}, safe=False)

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def conversation_messages(request, other_profile_id: int):
    me = _get_my_profile(request)
    if not me:
        return HttpResponseBadRequest("profile not found for this user")

    try:
        other = Profile.objects.get(pk=other_profile_id)
    except Profile.DoesNotExist:
        return HttpResponseBadRequest("other profile not found")

    # BLOCK CHECK
    if _is_any_blocked(me.id, other.id):
        return HttpResponseForbidden("messaging is blocked between these users")

    # açınca artık gizli değil
    PrivateMessageHiddenConversation.objects.filter(
        fk_owner_profile=me.id,
        fk_other_profile=other.id
    ).delete()

    qs = PrivateMessage.objects.filter(
        Q(fk_from_profile=me.id, fk_to_profile=other.id) |
        Q(fk_from_profile=other.id, fk_to_profile=me.id)
    ).order_by("pm_date", "id")

    PrivateMessage.objects.filter(
        fk_from_profile=other.id,
        fk_to_profile=me.id,
        is_viewed=False,
    ).update(is_viewed=True)

    messages = []
    for m in qs:
        messages.append({
            "id": m.id,
            "from_profile": m.fk_from_profile,
            "to_profile": m.fk_to_profile,
            "content": m.content,
            "pm_date": m.pm_date,
            "is_viewed": m.is_viewed,
            "type": m.type,
            "is_from_me": (m.fk_from_profile == me.id),
        })

    return JsonResponse({
        "other_profile": {
            "id": other.id,
            "username": other.username,
            "name": other.name,
            "lastname": other.lastname,
            "p_photo_link": other.p_photo_link or "",
        },
        "messages": messages,
    })
    

@api_view(["POST"])
@login_required
def feedback_create(request):
    profile_id = _get_my_profile_id(request)
    if not profile_id:
        return HttpResponseForbidden("profile not found for this user")

    body = request.data or {}
    f_type = (body.get("type") or "").strip()
    message = (body.get("message") or "").strip() or None

    if not f_type:
        return HttpResponseBadRequest("type is required")

    p = Profile.objects.filter(id=profile_id).only("id").first()
    if not p:
        return HttpResponseForbidden("profile not found")

    fb = Feedback.objects.create(
        profile=p,
        type=f_type,
        message=message,
    )

    return JsonResponse({
        "status": "ok",
        "id": fb.id,
        "profile_id": fb.profile_id,
        "type": fb.type,
        "message": fb.message or "",
    })
    
    
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def my_blocked_profiles(request):
    me = _get_my_profile(request)
    if not me:
        return JsonResponse({"results": []})

    blocked_ids = list(
        PrivateMessageBlocked.objects
        .filter(fk_blocker_profile=me.id)
        .values_list("fk_blocked_profile", flat=True)
    )

    profs = Profile.objects.filter(id__in=blocked_ids).only("id","username","name","lastname","p_photo_link")
    results = []
    for p in profs:
        results.append({
            "id": p.id,
            "username": p.username,
            "name": p.name,
            "lastname": p.lastname,
            "full_name": f"{p.name or ''} {p.lastname or ''}".strip(),
            "p_photo_link": p.p_photo_link or "",
        })

    return JsonResponse({"results": results}, safe=False)


@api_view(["POST", "DELETE"])
@permission_classes([IsAuthenticated])
def block_profile(request, profile_id: int):
    me = _get_my_profile(request)
    if not me:
        return HttpResponseBadRequest("profile not found")

    if me.id == profile_id:
        return HttpResponseBadRequest("you cannot block yourself")

    if not Profile.objects.filter(id=profile_id).exists():
        return HttpResponseBadRequest("target profile not found")

    if request.method == "DELETE":
        PrivateMessageBlocked.objects.filter(
            fk_blocker_profile=me.id,
            fk_blocked_profile=profile_id
        ).delete()
        return JsonResponse({"status": "ok", "blocked": False, "profile_id": profile_id})

    # POST -> block
    obj, created = PrivateMessageBlocked.objects.get_or_create(
        fk_blocker_profile=me.id,
        fk_blocked_profile=profile_id,
        defaults={"created_at": timezone.now()},
    )
    return JsonResponse({"status": "ok", "blocked": True, "profile_id": profile_id, "created": created})

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def my_hidden_conversations(request):
    me = _get_my_profile(request)
    if not me:
        return JsonResponse({"results": []})

    other_ids = list(
        PrivateMessageHiddenConversation.objects
        .filter(fk_owner_profile=me.id)
        .values_list("fk_other_profile", flat=True)
    )

    profs = Profile.objects.filter(id__in=other_ids).only("id","username","name","lastname","p_photo_link")
    results = []
    for p in profs:
        results.append({
            "id": p.id,
            "username": p.username,
            "name": p.name,
            "lastname": p.lastname,
            "full_name": f"{p.name or ''} {p.lastname or ''}".strip(),
            "p_photo_link": p.p_photo_link or "",
        })

    return JsonResponse({"results": results}, safe=False)


@api_view(["POST", "DELETE"])
@permission_classes([IsAuthenticated])
def hide_conversation(request, other_profile_id: int):
    me = _get_my_profile(request)
    if not me:
        return HttpResponseBadRequest("profile not found")

    if me.id == other_profile_id:
        return HttpResponseBadRequest("you cannot hide yourself")

    if not Profile.objects.filter(id=other_profile_id).exists():
        return HttpResponseBadRequest("other profile not found")

    if request.method == "DELETE":
        PrivateMessageHiddenConversation.objects.filter(
            fk_owner_profile=me.id,
            fk_other_profile=other_profile_id
        ).delete()
        return JsonResponse({"status": "ok", "hidden": False, "other_profile_id": other_profile_id})

    obj, created = PrivateMessageHiddenConversation.objects.get_or_create(
        fk_owner_profile=me.id,
        fk_other_profile=other_profile_id,
        defaults={"hidden_at": timezone.now()},
    )
    return JsonResponse({"status": "ok", "hidden": True, "other_profile_id": other_profile_id, "created": created})


'''




