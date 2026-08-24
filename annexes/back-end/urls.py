"""
URL configuration for elevateher_backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.shortcuts import redirect
from django.urls import path, include
from api import views
from api.jwt_views import TouchingTokenRefreshView
from api.mobile_auth import google_mobile_login, apple_mobile_login, email_register, email_login
from rest_framework_simplejwt.views import TokenRefreshView
from django.conf import settings
from django.conf.urls.static import static

def login_redirect(_):
    return redirect("socialaccount_login", provider="google")

urlpatterns = [

    #endpoints for modules
    path('categories/', views.get_categories, name='get_categories'),
    path('all-modules/', views.get_modules, name='get_modules'),

    #endpoints for simulators
    path('metrics/', views.get_metrics, name='get_metrics'),
    path('sim-tags/', views.get_simulator_tags, name='get_simulator_tags'),
    path('progress-statuses/', views.get_progress_statuses, name='get_progress_statuses'),
    path('sim-levels/', views.get_simulator_levels, name='get_simulator_levels'),
    path('all-simulators/', views.get_simulators, name='get_simulators'),
    path('simulator/<int:simulator_id>/tags/', views.get_simulator_specific_tags, name='get_simulator_specific_tags'),
    path('simulator/<int:simulator_id>/metrics/', views.get_simulator_specific_metrics, name='get_simulator_specific_metrics'),
    path('user/<int:user_id>/simulator/<int:simulator_id>/results/', views.get_simulator_results, name='get_simulator_results'),
    path('user/<int:user_id>/simulator/<int:simulator_id>/reset-scores/', views.reset_simulator_scores, name='reset_simulator_scores'),

    #endpoints for cards and its components
    path('<str:owner_type>/<int:owner_id>/cards/', views.get_entity_cards, name='get_entity_cards'),
    path('<str:owner_type>/<int:owner_id>/cards-full/', views.get_entity_cards_full, name='get_entity_cards_full'),
    path('cards/<int:card_id>/details/', views.get_cards_full_content, name='get_cards_full_details'),

    #endpoints for user-specific data
    path('user/<int:user_id>/progress/', views.get_user_progress, name='user_progress'),
    path('user/progress/update/', views.update_user_progress, name='update_progress'),
    path('user/response/open-question/', views.save_open_question_response, name='save_open_question'),
    path('user/response/mcq/', views.save_mcq_response, name='save_mcq_response'),

    #endpoints for daily check-in
    path('daily-checkin/questions/', views.get_daily_checkin_questions, name='get_checkin'),
    path('daily-checkin/submit/', views.submit_daily_checkin, name='submit_checkin'),

    #endpoints for story
    path('stories/', views.get_all_stories, name='get_all_stories'),
        # http://127.0.0.1:8000/stories/?user_id=1&viewer_id=1 to see personal stories
        # http://127.0.0.1:8000/stories/?category_id=1 to see stories by category
    path('stories/pending/', views.get_pending_stories, name='get_pending_stories'),
    path('story-tags/', views.get_story_tags, name='get_all_stories'),
    path('stories/create/', views.create_story, name='create_story'),
    path('stories/<int:story_id>/delete/', views.delete_story, name='delete_story'),
    path('stories/<int:story_id>/moderate/', views.moderate_story, name='moderate_story'),
    path('stories/react/', views.toggle_story_reaction, name='toggle_reaction'),

    # endpoint for Kokoro TTS audio generation
    path('audio/generate/<str:owner_type>/<int:owner_id>/', views.generate_audio, name='generate_audio'),
    path('audio/fetch/<str:owner_type>/<int:owner_id>/', views.fetch_audio, name='fetch_audio'),


    # mevcut path'lerin yanına:
    path("auth/email/register", email_register),
    path("auth/email/login", email_login),

    ##path('admin/', admin.site.urls),
    path('auth/sessionLogin', views.session_login),
    path("profile/by-user/<int:user_id>", views.profile_by_user),
    ##path("profile/<int:pk>", views.profile_detail),
    ##path("profile/<int:pk>/update", views.profile_update),

    ##path("messages/send/<int:to_profile_id>/", views.send_message, name="send_message"),
    ##path("messages/conversations/", views.my_conversations, name="my_conversations"),
    ##path("messages/conversation/<int:other_profile_id>/", views.conversation_messages, name="conversation_messages"),

    #path("notifications/latest", views.notifications_latest, name="notifications_latest"),
    #path("notifications/<int:pk>/seen", views.notification_mark_seen),


    #path("upload/profile-photo", views.upload_profile_photo),
    path("accounts/", include("allauth.urls")),  # gives you /accounts/google/login/ etc.
    path("accounts/login/", login_redirect, name="account_login"),
    path('auth/logout', views.logout),
    path('auth/me', views.me),
    path('auth/csrf', views.csrf),

        # TEST endpoint’leri
    # path('protected', views.protected_view), # GET /protected -> auth gerekli
    path("auth/google/mobile", google_mobile_login),   # POST {id_token}
    path("auth/apple/mobile",  apple_mobile_login),    # POST {id_token}
    path("auth/token/refresh", TouchingTokenRefreshView.as_view(), name="token_refresh"),
    # path("feedback/create", views.feedback_create),

    #path("messages/blocked/", views.my_blocked_profiles, name="my_blocked_profiles"),          # GET
    #path("messages/blocked/<int:profile_id>/", views.block_profile, name="block_profile"),    # POST / DELETE
    #path("messages/hidden/", views.my_hidden_conversations, name="my_hidden_conversations"),  # GET
    #path("messages/hidden/<int:other_profile_id>/", views.hide_conversation, name="hide_conversation"),  # POST / DELETE

]

""" Serving media files during development """
# from django.conf import settings
# from django.conf.urls.static import static

# urlpatterns = [
#     ...
# ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)