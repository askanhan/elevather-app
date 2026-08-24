from django.db import models
from django.utils import timezone
# api/models.py


class ProgressStatus:
    """
    Enum for user progress status values
    """
    NOT_STARTED = 'Not started'
    IN_PROGRESS = 'In progress'
    DONE = 'Done'
    
    CHOICES = [
        (NOT_STARTED, 'Not started'),
        (IN_PROGRESS, 'In progress'),
        (DONE, 'Done'),
    ]

class SimulatorLevel:
    """
    Enum for simulator level values
    """
    INTRO = 'intro'
    CORE = 'core'
    ADVANCED = 'advanced'

    CHOICES = [
        (INTRO, 'Intro'),
        (CORE, 'Core'),
        (ADVANCED, 'Advanced'),
    ]

class ComponentImage(models.Model):
    """
    Model for images component.
    """
    id = models.AutoField(primary_key=True)
    image_url = models.CharField(max_length=255)
    image_alt = models.CharField(max_length=255, null=True, blank=True)
    image_description = models.TextField(null=True, blank=True)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_image'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentLastMessage(models.Model):
    """
    Model for last messages component.
    """
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=255)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_last_messages'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentList(models.Model):
    """
    Model for lists component.
    """
    id = models.AutoField(primary_key=True)
    content = models.TextField()

    class Meta:
        #link to the existing table in the database
        db_table = 'component_list'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentMCQ(models.Model):
    """
    Model for mcq component.
    """
    id = models.AutoField(primary_key=True)
    question = models.TextField(null=True, blank=True)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_mcq'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentOpenQuestion(models.Model):
    """
    Model for open questions component.
    """
    id = models.AutoField(primary_key=True)
    question = models.TextField(null=True, blank=True)
    placeholder = models.CharField(max_length=255, null=True, blank=True)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_open_questions'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentQuote(models.Model):
    """
    Model for quotes component.
    """
    id = models.AutoField(primary_key=True)
    content = models.TextField()
    author = models.CharField(max_length=255)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_quote'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentSubtitle(models.Model):
    """
    Model for subtitles component.
    """
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=255)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_subtitle'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentText(models.Model):
    """
    Model for texts component.
    """
    id = models.AutoField(primary_key=True)
    content = models.TextField()

    class Meta:
        #link to the existing table in the database
        db_table = 'component_text'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentTitle(models.Model):
    """
    Model for titles component.
    """
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=255)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_title'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ComponentVideo(models.Model):
    """
    Model for videos component.
    """
    id = models.AutoField(primary_key=True)
    video_url = models.CharField(max_length=255)
    video_duration_est = models.IntegerField(null=True, blank=True)
    video_alt = models.CharField(max_length=255, null=True, blank=True)
    video_description = models.CharField(max_length=255, null=True, blank=True)

    class Meta:
        #link to the existing table in the database
        db_table = 'component_video'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class MCQOptions(models.Model):
    """
    Model for options of MCQ component.
    """
    id = models.AutoField(primary_key=True)
    mcq = models.ForeignKey(ComponentMCQ, on_delete=models.CASCADE, db_column='mcq_id')
    option_text = models.CharField(max_length=255)
    feedback = models.CharField(max_length=255)

    class Meta:
        #link to the existing table in the database
        db_table = 'multiple_choices_options'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class SimulatorMetric(models.Model):
    """
    Model for metrics of simulators.
    """
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)

    class Meta:
        #link to the existing table in the database
        db_table = 'simulator_metric'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class SimulatorTag(models.Model):
    """
    Model for tags of simulators.
    """
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)

    class Meta:
        #link to the existing table in the database
        db_table = 'simulator_tag'
        #no need to manage this table with Django, it will be created and managed directly in the database
        managed = False

class ModuleCategory(models.Model):
    """
    Model for categories of modules.
    """
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField()

    class Meta:
        #link to the existing table in the database
        db_table = 'module_category'
        #no need to manage this table with Django, it will be created and managed directly in the database
        # Allow Django to manage tables during testing
        managed = False

class Module(models.Model):
    """
    Model for modules.
    """
    id = models.AutoField(primary_key=True)
    module_category = models.ForeignKey(ModuleCategory, on_delete=models.DO_NOTHING, null=True, db_column='module_category_id')
    day_number = models.IntegerField()
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    target_audience = models.CharField(max_length=255, blank=True, null=True)
    estimated_duration = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField()

    class Meta:
        db_table = 'module'
        managed = False

class Simulator(models.Model):
    """
    Model for simulators.
    """
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    level = models.CharField(max_length=50)
    localisation = models.CharField(max_length=255, blank=True, null=True)
    estimated_duration = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField()
    class Meta:
        db_table = 'simulator'
        managed = False

class SimulatorContainsTag(models.Model):
    """
    Model for the relation between simulators and tags.
    """
    id = models.AutoField(primary_key=True)
    #link the simulator to the relation table
    simulator = models.ForeignKey(
        'Simulator',
        on_delete=models.CASCADE,
        db_column='simulator_id'
    )
    #link the tag to the relation table
    simulator_tag = models.ForeignKey(
        'SimulatorTag',
        on_delete=models.CASCADE,
        db_column='simulator_tag_id'
    )

    class Meta:
        db_table = 'simulator_contains_tag'
        managed = False

class SimulatorContainsMetrics(models.Model):
    """
    Model for the relation between simulators and metrics.
    """
    id = models.AutoField(primary_key=True)
    #link the simulator to the relation table
    simulator = models.ForeignKey(
        'Simulator',
        on_delete=models.CASCADE,
        db_column='simulator_id'
    )
    #link the metric to the relation table
    metric = models.ForeignKey(
        'SimulatorMetric',
        on_delete=models.CASCADE,
        db_column='metric_id'
    )

    class Meta:
        db_table = 'simulator_contains_metric'
        managed = False

class Card(models.Model):
    """
    Model for cards of simulators.
    """
    id = models.AutoField(primary_key=True)
    owner_type = models.CharField(max_length=50)
    owner_id = models.IntegerField()
    card_order_index = models.IntegerField()
    title = models.CharField(max_length=255, null=True, blank=True)
    subtitle = models.CharField(max_length=255, null=True, blank=True)
    end_text = models.TextField(null=True, blank=True)
    why_this_question = models.TextField(null=True, blank=True)

    class Meta:
        db_table = 'card'
        managed = False
        ordering = ['card_order_index']

class CardContains(models.Model):
    """
    Model for the relation between cards and components.
    """
    id = models.AutoField(primary_key=True)
    card = models.ForeignKey(Card, on_delete=models.CASCADE, db_column='card_id')
    component_type = models.CharField(max_length=50)
    component_order_index = models.IntegerField()
    component_id = models.IntegerField()

    class Meta:
        db_table = 'card_contains'
        managed = False
        ordering = ['component_order_index']

class UserProgress(models.Model):
    """
    Model for tracking user progress on simulators and modules.
    """
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField() #should be ForeignKey to Profile
    owner_type = models.CharField(max_length=50)
    owner_id = models.IntegerField()
    status = models.CharField(max_length=50)
    last_accessed_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'user_progress'
        managed = False

class UserResponseOpenQuestions(models.Model):
    """
    Model for storing user answers to open questions in a module.
    """
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField() #should be ForeignKey to Profile
    open_question = models.ForeignKey(ComponentOpenQuestion, on_delete=models.CASCADE, db_column='open_question_id')
    answer_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_response_open_questions'
        managed = False

class UserResponseMCQ(models.Model):
    """
    Model for storing user answers to MCQ in a module or simulator.
    """
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField() #should be ForeignKey to Profile
    selected_option = models.ForeignKey(
        MCQOptions,
        on_delete=models.CASCADE,
        db_column='selected_option_id'
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_response_mcq'
        managed = False

class DailyCheckinMetric(models.Model):
    """
    Model for daily check-in metrics.
    """
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)

    class Meta:
        db_table = 'daily_checkin_metric'
        managed = False

class DailyCheckinQuestion(models.Model):
    """
    Model for daily check-in questions linked to a metric.
    """
    id = models.AutoField(primary_key=True)
    question_text = models.TextField()
    metric = models.ForeignKey(DailyCheckinMetric, on_delete=models.DO_NOTHING, db_column='metric_id')

    class Meta:
        db_table = 'daily_checkin_question'
        managed = False

class DailyCheckinOption(models.Model):
    """
    Model for options of daily check-in questions, with associated score values.
    """
    id = models.AutoField(primary_key=True)
    question = models.ForeignKey(DailyCheckinQuestion, on_delete=models.DO_NOTHING, db_column='question_id')
    option_text = models.CharField(max_length=255)
    score_value = models.IntegerField()

    class Meta:
        db_table = 'daily_checkin_option'
        managed = False

class UserDailyPowerCheck(models.Model):
    """
    Model for storing the total power level of a user based on their daily check-in responses.
    """
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField() #should be ForeignKey to Profile
    total_power_level = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_daily_power_check'
        managed = False

class UserDailyCheckinResponse(models.Model):
    """
    Model for storing user responses to daily check-in questions, linked to the selected option and the user.
    """
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField() #should be ForeignKey to Profile
    option = models.ForeignKey(DailyCheckinOption, on_delete=models.DO_NOTHING, db_column='option_id')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_daily_checkin_response'
        managed = False

class MultipleChoicesOptionsWeights(models.Model):
    """
    Model for storing the weights of MCQ options for each simulator metric.
    """
    id = models.AutoField(primary_key=True)
    multiple_choices_options = models.ForeignKey(
        'MCQOptions', on_delete=models.CASCADE, db_column='multiple_choices_options_id'
    )
    simulator_metric = models.ForeignKey(
        'SimulatorMetric', on_delete=models.CASCADE, db_column='simulator_metric_id'
    )
    weight = models.IntegerField()

    class Meta:
        db_table = 'multiple_choices_options_weights'
        managed = False

class UserScoreSimulator(models.Model):
    """
    Model for storing the score of a user on a simulator based on their responses to MCQs
    and the weights of the options they selected.
    """
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()  #should be ForeignKey to Profile
    metric = models.ForeignKey(
        'SimulatorMetric',
        on_delete=models.CASCADE,
        db_column='metric_id'
    )
    #default score value is set to 50 for a neutral starting point
    score_value = models.IntegerField(default=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'user_score_simulator'
        managed = False

class SimulatorFeedbackTiers(models.Model):
    """
    Model for defining feedback tiers for simulators based on user scores on different metrics.
    This model will help determine the feedback, strengths, risks, and recommended modules for users
    based on their performance in the simulator.
    """
    id = models.AutoField(primary_key=True)
    simulator = models.ForeignKey('Simulator', on_delete=models.CASCADE, db_column='simulator_id')
    metric = models.ForeignKey('SimulatorMetric', on_delete=models.CASCADE, db_column='metric_id')
    min_score = models.IntegerField()
    max_score = models.IntegerField()
    strength_result = models.TextField()
    risk_result = models.TextField()
    micro_practice = models.TextField()
    recommended_module = models.ForeignKey('Module', on_delete=models.SET_NULL, null=True, db_column='recommended_module_id')
    recommendation_reason = models.TextField()

    class Meta:
        db_table = 'simulator_feedback_tiers'
        managed = False

class UserStory(models.Model):
    """
    Model for user stories shared by users, including their content, author, category.
    """
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField() #should be ForeignKey to Profile
    author_name = models.CharField(max_length=255, default='Anonymous')
    category = models.ForeignKey('ModuleCategory', on_delete=models.SET_NULL, null=True, db_column='category_id')
    localisation = models.CharField(max_length=255, null=True, blank=True)
    content = models.TextField()
    is_published = models.BooleanField(default=False)  # Le nouveau champ de modération
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_story'
        managed = False

class UserStoryTag(models.Model):
    """
    Model for tags that can be associated with user stories to facilitate categorization and search.
    """
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)

    class Meta:
        db_table = 'user_story_tag'
        managed = False

class StoryContainsTag(models.Model):
    """
    Model for the relation between stories and tags.
    """
    id = models.AutoField(primary_key=True)
    story = models.ForeignKey(UserStory, on_delete=models.CASCADE, db_column='story_id')
    story_tag = models.ForeignKey(UserStoryTag, on_delete=models.CASCADE, db_column='story_tag_id')

    class Meta:
        db_table = 'story_contains_tag'
        managed = False

class UserStoryReaction(models.Model):
    """
    Model for reactions to user stories, allowing users to express how they relate to or are impacted by the story.
    """
    id = models.AutoField(primary_key=True)
    story = models.ForeignKey(UserStory, on_delete=models.CASCADE, db_column='story_id')
    user_id = models.IntegerField() #should be ForeignKey to Profile
    reaction_type = models.CharField(max_length=50) # 'relatable', 'support', 'powerful', 'inspiring'
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_story_reaction'
        managed = False

class Profile(models.Model):
    """
    Ghost model to fix dependencies with the accounts app.
    This model is managed=False and has no fields to avoid
    creating unnecessary tables.
    """
    class Meta:
        managed = False
        db_table = 'user_profile' # ou le nom qu'elle avait avant
#may be utilized for elevateher ?
'''
class Profile(models.Model):
    id = models.AutoField(primary_key=True, db_column="id")
    username = models.CharField(max_length=255, db_column="username")
    name = models.CharField(max_length=255, null=True, blank=True, db_column="name")
    lastname = models.CharField(max_length=255, null=True, blank=True, db_column="lastname")
    bio = models.CharField(max_length=1023, null=True, blank=True, db_column="bio")
    p_photo_link = models.CharField(max_length=1023, null=True, blank=True, db_column="p_photo_link")
    nofviews = models.IntegerField(null=True, blank=True, db_column="nofviews")
    is_visible = models.BooleanField(default=True, db_column="is_visible")
    showmail = models.BooleanField(default=False, db_column="showmail")
    lastupdate = models.DateTimeField(db_column="lastupdate")
    fk_province = models.IntegerField(null=True, blank=True, db_column="fk_province")
    fk_user_id = models.BigIntegerField(null=True, blank=True, db_column="fk_user_id")

    class Meta:
        db_table = "profile"
        managed = False
    
class Notification(models.Model):
    TYPE_LIKE = 1
    TYPE_COMMENT = 2
    TYPE_FOLLOW = 3
    TYPE_NEW_POST = 5
    TYPE_BOOKMARK = 6   # <= YENİ

    TYPE_CHOICES = (
        (TYPE_LIKE, "like"),
        (TYPE_COMMENT, "comment"),
        (TYPE_FOLLOW, "follow"),
        (TYPE_NEW_POST, "new_post"),
        (TYPE_BOOKMARK, "bookmark"),  # <= YENİ
    )

    id = models.AutoField(primary_key=True, db_column="id")
    type = models.PositiveSmallIntegerField(db_column="type", choices=TYPE_CHOICES)
    is_seen = models.BooleanField(db_column="is_seen", default=False)
    created_on = models.DateTimeField(db_column="created_on", default=timezone.now)
    nofview = models.PositiveSmallIntegerField(db_column="nofview", default=1)

    fk_for_profile = models.IntegerField(db_column="fk_for_profile")
    fk_by_profile = models.IntegerField(db_column="fk_by_profile")
    fk_post = models.IntegerField(db_column="fk_post", null=True, blank=True)

    class Meta:
        db_table = "notification"
        managed = False
        ordering = ["-created_on", "-id"]

"""

"""
class Follow(models.Model):
    "
    follow tablosu:
      id              int (AI, PK)
      getnotified     tinyint
      fo_date         timestamp
      fk_following_pr int  (takip eden profil id)
      fk_followed_pr  int  (takip edilen profil id)
    "
    id = models.AutoField(primary_key=True, db_column="id")
    getnotified = models.PositiveSmallIntegerField(
        db_column="getnotified",
        default=1,
        blank=True,
        null=True,
    )
    fo_date = models.DateTimeField(
        db_column="fo_date",
        default=timezone.now,
    )
    fk_following_pr = models.IntegerField(db_column="fk_following_pr")
    fk_followed_pr = models.IntegerField(db_column="fk_followed_pr")

    class Meta:
        db_table = "follow"
        managed = False
        # aynı çiftten sadece bir tane olsun
        unique_together = (("fk_following_pr", "fk_followed_pr"),)
        ordering = ["-fo_date", "-id"]

    def __str__(self):
        return f"{self.fk_following_pr} -> {self.fk_followed_pr}"
    
    
    
# api/models.py


class PrivateMessage(models.Model):
    TYPE_NORMAL = 0

    id = models.AutoField(primary_key=True, db_column="id")
    pm_date = models.DateTimeField(db_column="pm_date", default=timezone.now)
    is_viewed = models.BooleanField(db_column="is_viewed", default=False)
    type = models.PositiveSmallIntegerField(db_column="type", default=TYPE_NORMAL)
    content = models.CharField(db_column="content", max_length=2048)

    fk_from_profile = models.IntegerField(db_column="fk_from_profile")
    fk_to_profile = models.IntegerField(db_column="fk_to_profile")

    class Meta:
        db_table = "private_message"   # tablo adını senin DB’ye göre düzelt
        managed = False
        ordering = ["-pm_date", "-id"]

    def __str__(self):
        return f"PM #{self.id} {self.fk_from_profile} -> {self.fk_to_profile}"

class Feedback(models.Model):
    profile = models.ForeignKey(
        "Profile",
        on_delete=models.CASCADE,
        db_column="profile_id",
        related_name="feedbacks",
    )
    type = models.CharField(db_column="type", max_length=255)
    message = models.CharField(db_column="message", max_length=1024, null=True, blank=True)

    class Meta:
        db_table = "feedback"
        managed = False
        
        
# api/models.py


class PrivateMessageBlocked(models.Model):
    id = models.AutoField(primary_key=True, db_column="id")
    created_at = models.DateTimeField(db_column="created_at", default=timezone.now)

    fk_blocker_profile = models.IntegerField(db_column="fk_blocker_profile")
    fk_blocked_profile = models.IntegerField(db_column="fk_blocked_profile")

    class Meta:
        db_table = "private_message_blocked"
        managed = False
        unique_together = (("fk_blocker_profile", "fk_blocked_profile"),)
        ordering = ["-created_at", "-id"]


class PrivateMessageHiddenConversation(models.Model):
    id = models.AutoField(primary_key=True, db_column="id")
    hidden_at = models.DateTimeField(db_column="hidden_at", default=timezone.now)

    fk_owner_profile = models.IntegerField(db_column="fk_owner_profile")
    fk_other_profile = models.IntegerField(db_column="fk_other_profile")

    class Meta:
        db_table = "private_message_hidden_conversations"
        managed = False
        unique_together = (("fk_owner_profile", "fk_other_profile"),)
        ordering = ["-hidden_at", "-id"]
'''