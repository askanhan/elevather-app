# Map for path construction based on content type
FOLDER_MAP = {
    "course": "courses",
    "simulator": "simulators"
}
# Map to translate fields in Excel to database columns for module table
MODULE_TABLE_MAP = {
    "Course Title": "title",
    "Category": "category_name",
    "Day": "day_number",
    "Target Audience" : "target_audience",
    "Estimated Duration (minutes)": "estimated_duration",
    "Learning Goal (1 sentence)": "description"
}
# Map to translate fields in Excel to database columns for components table
COMPONENTS_TABLES_MAP = {
    "Title": {"table": "component_title", "column": "content", "enum": "title" },
    "Text": {"table": "component_text", "column": "content", "enum": "text"},
    "Quote": {"table": "component_quote", "column": "content", "enum": "quote"},
    "Image": {"table": "component_image", "column": "image_url", "enum": "image"},
    "Video": {"table": "component_video", "column": "video_url", "enum": "video"},
    "Subtitle": {"table": "component_subtitle", "column": "content", "enum": "subtitle"},
    "Multiple choice question": {"table": "component_mcq", "column": "question", "enum": "mcq"},
    "Open question": {"table": "component_open_questions", "column": "question", "enum": "open question"},
    "List": {"table": "component_list", "column": "content", "enum": "list"},
    "Last message": {"table": "component_last_messages", "column": "content", "enum": "last message"}
}
# Map to translate fields in Excel to database columns for simulator table
SIMULATOR_TABLE_MAP = {
    "Simulator Title": "title",
    "Level (Intro/Core/Advanced)": "level",
    "Estimated Duration (minutes)": "estimated_duration",
    "Setting (work/home/community)": "localisation",
    "Tags (comma separated)": "tags",
    "Metrics (comma separated)": "metrics"
}
# Map for overall results sheet for simulator
SIMULATOR_OVERALL_RESULTS_MAP = {
    "Score Range (<50 / 50-85 / 85-100)": "score_range",
    "One-Sentence Result Title": "result_title"
}

# Fixed course title per source file, keyed by filename. Overrides a raw
# Excel title that's actually a leftover placeholder rather than real content.
TITLE_OVERRIDES = {
    "KANE_DAY14_LeadershipANDPersonal Growth.xlsx": "Knowing Yourself as a Leader - Leading your own way",
}

# Fixed day_number per translation file, keyed by filename - for locale folders
# whose own file names are unreliable (a leading/embedded number that doesn't
# match the canonical day, e.g. cz/days/"23_Day_BORIS_Course_Template..." is
# actually day 21's content, verified by opening the file and reading its
# Course Title / Card sheets). Checked before any automatic (regex or
# normalized-filename) day resolution - see translation_importer.resolve_day_number().
COURSE_TRANSLATION_DAY_OVERRIDES = {
    # cz/days - verified against each file's actual Course Title / Card content,
    # since this folder's filenames turned out not to reliably match the
    # canonical day (either a reused generic "BORIS_Course_Template" name
    # shared by days 1/2/21/24, or a day number local to that translator's
    # own ordering rather than the platform's 1-30 sequence).
    "1_AVITEUM_Course_Day_13_BRAND_CZ_OK.xlsx": 12,
    "1_AVITEUM_Course_Day_6_SELF-CARE_CZ_OK.xlsx": 5,
    "1_AVITEUM_Course_Day_7_BREATHWORK_CZ_OK.xlsx": 6,
    "1_AVITEUM_Course_Day_8_MEDITATION_CZ_OK.xlsx": 7,
    "1_AVITEUM_Course_Day_9_CREATIVITY_CZ_OK.xlsx": 8,
    "1_AVITEUM_Course_Ikigai_CZ_OK.xlsx": 3,
    "23_Day_BORIS_Course_Template_cs_translation OK.xlsx": 21,
    "24_Day_BORIS_Course_Template_cs_translation OK.xlsx": 24,
    "DAY_12__Digital_Courage__Setting_Boundaries___Showing_Up_Safely_Online_translation cz_OK.xlsx": 11,
    "DE_1_cs_HANNAH_ARENDT_translation cz_OK.xlsx": 26,
    "DE_2_cs_ADA_LOVELACE_translation cz_OK.xlsx": 27,
    "Day_25_Power_translation cz_OK.xlsx": 25,
    "Day_28_MOMO_cs_translation cz_OK.xlsx": 28,
    "KANE_DAY15_LeadershipANDPersonal_Growth_translation cz_OK.xlsx": 14,
    "KANE_DAY16_Proactive_Leadership_translation cz_OK.xlsx": 15,
    "KANE_DAY17_Personal_Growth_translation cz_OK.xlsx": 16,
    "KANE_DAY18_Designingyourownpath_translation cz_OK.xlsx": 17,
    "KANE_DAY19_VisionConfidence_MovingForward_translation cz_OK.xlsx": 18,
    "Motivational_Techniques_translation cz_OK.xlsx": 23,
    "OK_10_Day_BORIS_Get_ready_to_public_speaking_cs_translation OK.xlsx": 9,
    "OK_11_Day_BORIS_Public_speaking_cs_translation Ok.xlsx": 10,
    "OK_1_Day_BORIS_Course_Template_cs_translation OK.xlsx": 1,
    "OK_2_Day_BORIS_Course_Template_cs_translation OK.xlsx": 2,
    "Smart_DAY_5__Story_of_Me__Rewriting_Your_Power_Narrative_translation cz_OK.xlsx": 4,
    "VisionTree_Course01_SelfConfidence_translation cz_OK.xlsx": 13,
    "VisionTree_Course03_Networking_translation cz_OK.xlsx": 19,
    "VisionTree_Course04_Partnering_translation cz_OK.xlsx": 20,
    "VisionTree_Course05_Thankfulness_translation cz_OK.xlsx": 22,
    "VisionTree_Course06_AI_translation cz_OK.xlsx": 30,
    "VisionTree_Course07_Day5_RebiyaKadeer_1_CZ.xlsm": 29,
    # Deliberately NOT mapped: "KANE_sixth_contribution_translation cz_OK.xlsx"
    # - its own Course Overview sheet has "Day: ?" (unresolved even in the
    # source) and its title ("Growth through challenges") doesn't clearly
    # match any of days 14-18's exact titles. Left unmatched rather than guessed.
}

# Fixed day_number per course, keyed by exact course title. Each country's Excel
# "Day" column is numbered relative to its own local course order, not the combined
# platform sequence, so it's overridden here to the canonical 1-30 order across all
# countries instead of trusting the Excel value.
DAY_NUMBER_OVERRIDES = {
    "Discover your inner potential": 1,
    "Discover Your Personality: The Big Five Model": 2,
    "Ikigai: Discover your purpose": 3,
    "Story of me: Rewriting your power narrative": 4,
    "Self-Care for Strong Leaders": 5,
    "Breathwork for Focus and Balance": 6,
    "Mindful Meditation Moments": 7,
    "Unlocking Creativity & Vision": 8,
    "Get ready for public speaking": 9,
    "Public speaking - staying strong in the spotlight": 10,
    "Digital Courage: Setting Boundaries & Showing Up Safely Online": 11,
    "Personal Brand Building: Lead With Your Story": 12,
    "Strategies and Tools to Strengthen Self-Confidence": 13,
    "Knowing Yourself as a Leader - Leading your own way": 14,
    "Proactive Leadership in Daily Life": 15,
    "Believing in Your Growth": 16,
    "Designing Your Growth Path": 17,
    "Vision, Confidence & Moving Forward": 18,
    "Networking: Building Real, Warm Connections": 19,
    "Partnering: The Power of Building Things with Others": 20,
    "How to speak to gain allies for your actions?": 21,
    "Thankfulness: The Quiet Psychological Relief": 22,
    "Motivational Techniques for Daily Life": 23,
    "React to discrimination – don’t be indifferent": 24,
    "Empowerment to... But what does power mean?": 25,
    "„I want to understand.“ - HANNAH ARENDT": 26,
    "Pioneer of Computer Science - ADA LOVELACE ": 27,
    "Silent Heros: The power of listening and the liberation of time": 28,
    "Day 5: Rebiya Kadeer — Staying Strong Under Pressure": 29,
    "A Brief Use of AI: What You Can Actually Do With It": 30,
}

# Translation Excel files under data-sources/translations/<locale>/simulators/ don't
# retain any English identifier (even "Simulator Title" is fully translated), so unlike
# courses (matched via day number) each translated simulator file must be mapped by hand
# to the exact title of the already-imported Simulator row it translates.
SIMULATOR_TRANSLATION_TITLE_MAP = {
    " Power Simulator_IKIGAI_PL_Zdenka.final.xlsx": "Find your IKIGAI: Purpose discovering challenge",
    "Power_ Simulator_Public_Speaking_PL_BORIS..KasiaBxlsx.xlsx": "Public Speaking",
    "Power_Simulator_AI_PL_Vision_Tree.xlsx": "AI in Your Hands: Healthy, Practical, Self-Sufficient Use",
    "Power_Simulator_Networking_PL_VisionTree.xlsx": "Networking with Nerve: Assertive, Composed, Strategic, Kind",
    "Power_Simulator_SelfCare_PL_final.Zdenka.xlsx": "Self-Care for Strong Leaders",
    "Power_Simulator_UsingYourPowerAuthentically_PL_Fotini.xlsx": "Using Your Power Authentically",
    "Power_simulator_RecognizingYourPower_PL_Fotini.xlsx": "Recognizing Your Power",
    "The opportunity_Power_Simulator_PL_BORIS_Aga.xlsx": "The opportunity you didn't expect",

    # be/ folder (Dutch/"nl" content, despite the country-code folder name)
    "Power_Simulator_IKIGAI_CZ_final_NL.xlsx": "Find your IKIGAI: Purpose discovering challenge",
    "Public_speaking_Power__Simulator_BORIS_NL.xlsx": "Public Speaking",
    "VisionTree_Power_Simulator_AI_NL.xlsx": "AI in Your Hands: Healthy, Practical, Self-Sufficient Use",
    "VisionTree_Power_Simulator_Networking_NL.xlsx": "Networking with Nerve: Assertive, Composed, Strategic, Kind",
    "Power_Simulator_SelfCare_CZ_final_NL.xlsx": "Self-Care for Strong Leaders",
    "Power_Simulator_UsingYourPowerAuthentically_NL.xlsx": "Using Your Power Authentically",
    "Power_simulator_RecognizingYourPower_NL.xlsx": "Recognizing Your Power",
    "The_opportunity_Power_Simulator_BORIS_NL.xlsx": "The opportunity you didn't expect",
    "DAY_12__Digital_Courage____Power_Simulator_xlsx_NL.xlsx": "Your Voice, Your Space",
    "Rewriting_your_power_narrative__Power_Simulator_NL.xlsx": "The Meeting That Changed Your Narrative",

    # cz/ folder (Czech/"cs" content)
    "DAY_12__Digital_Courage__Power_Simulator_translation cz_OK.xlsx": "Your Voice, Your Space",
    "Power_Simulator_IKIGAI_translation CZ_OK.xlsx": "Find your IKIGAI: Purpose discovering challenge",
    "Power_Simulator_RecognizingYourPower_translation cz_OK.xlsx": "Recognizing Your Power",
    "Power_Simulator_SelfCare_translation CZ_OK.xlsx": "Self-Care for Strong Leaders",
    "Power_Simulator_UsingYourPowerAuthentically_translation cz_OK.xlsx": "Using Your Power Authentically",
    "Public_speaking_Power_Simulator_BORIS_cs_translation OK.xlsx": "Public Speaking",
    "Rewriting_your_power_narrative__Power_Simulator_translation cz_OK.xlsx": "The Meeting That Changed Your Narrative",
    "The_opportunity_Power_Simulator_BORIS_cs_translation CZ.xlsx": "The opportunity you didn't expect",
    "VisionTree_Power_Simulator_AI_CZ.xlsx": "AI in Your Hands: Healthy, Practical, Self-Sufficient Use",
    "VisionTree_Power_Simulator_Networking_CZ.xlsx": "Networking with Nerve: Assertive, Composed, Strategic, Kind",

    # gr/ folder (Greek/"el" content)
    "Digital_Courage_Power_Simulator_GR.xlsx": "Your Voice, Your Space",
    "Power_Simulator_IKIGAI_CZ_final_GR.xlsx": "Find your IKIGAI: Purpose discovering challenge",
    "Power_Simulator_SelfCare_CZ_final_GR.xlsx": "Self-Care for Strong Leaders",
    "Power_Simulator_UsingYourPowerAuthentically_GR.xlsx": "Using Your Power Authentically",
    "Power_simulator_RecognizingYourPower_GR.xlsx": "Recognizing Your Power",
    "Public_speaking_Power_Simulator_BORIS_GR.xlsx": "Public Speaking",
    "Rewriting_your_power_narrative_Power_Simulator_GR.xlsx": "The Meeting That Changed Your Narrative",
    "The_opportunity_Power_Simulator_BORIS_GR.xlsx": "The opportunity you didn't expect",
    "VisionTree_Power_Simulator_AI_GR.xlsx": "AI in Your Hands: Healthy, Practical, Self-Sufficient Use",
    "VisionTree_Power_Simulator_Networking_GR.xlsx": "Networking with Nerve: Assertive, Composed, Strategic, Kind",
}

# Two cz/simulators files (the AI and Networking ones) translate every sheet
# AND column header, not just cell content - unlike every other translation
# file seen so far, which keeps the English structural labels and only
# translates the content. Column names are renamed back to English (see
# translation_importer.normalize_czech_headers()) before those sheets go
# through the normal English-header-driven parsing (map_excel_to_db,
# extract_simulator_cards, etc.) - safe to apply to every file since it's a
# no-op when the columns are already English.
CZECH_SIMULATOR_OVERVIEW_HEADER_MAP = {
    'Název simulátoru': 'Simulator Title',
    'Úroveň (Úvodní/Základní/Pokročilá)': 'Level (Intro/Core/Advanced)',
    'Odhadovaná délka (minuty)': 'Estimated Duration (minutes)',
    'Prostředí (práce/domov/komunita)': 'Setting (work/home/community)',
    'Štítky (oddělené čárkami)': 'Tags (comma separated)',
    'Metriky (oddělené čárkami)': 'Metrics (comma separated)',
}

CZECH_SIMULATOR_CARDS_HEADER_MAP = {
    'Pořadí karty': 'Card Order',
    'Název': 'Title',
    'Podnázev': 'Subtitle',
    'Text situace': 'Situation Text',
    'Popis vizuálu (odkaz) nebo jiné': 'Visual Description (link) or other',
    'Alternativní text obrázku': 'Image Alt',
    'Popis obrázku': 'Image Description',
    'Odhadovaná délka videa': 'Video Duration Est',
    'Alternativní text videa': 'Video Alt',
    'Popis videa': 'Video Description',
    'Text akce 1': 'Action 1 Text',
    'Zpětná vazba k akci 1': 'Action 1 Feedback',
    'Vliv akce 1 na metriky': 'Action 1 Metric Effects',
    'Text akce 2': 'Action 2 Text',
    'Zpětná vazba k akci 2': 'Action 2 Feedback',
    'Vliv akce 2 na metriky': 'Action 2 Metric Effects',
    'Text akce 3': 'Action 3 Text',
    'Zpětná vazba k akci 3': 'Action 3 Feedback',
    'Vliv akce 3 na metriky': 'Action 3 Metric Effects',
    'Proč tato otázka': 'Why This Question',
    'Závěrečný text': 'End_text',
}

CZECH_COURSE_OVERVIEW_HEADER_MAP = {
    'Název kurzu': 'Course Title',
    'Kategorie': 'Category',
    'Den': 'Day',
    'Cílová skupina': 'Target Audience',
    'Odhadovaná délka (minuty)': 'Estimated Duration (minutes)',
    'Cíl učení (1 věta)': 'Learning Goal (1 sentence)',
}

CZECH_SIMULATOR_METRIC_WRITING_HEADER_MAP = {
    'Název metriky': 'Metric Name',
    'Rozmezí skóre (<50 / 50–85 / 85–100)': 'Score Range (<50 / 50-85 / 85-100)',
    'Text silné stránky': 'Strength Text',
    'Text rizika': 'Risk Text',
    'Doporučené mikrocvičení': 'Suggested Micro-Practice',
    'Doporučený modul': 'Recommended Module',
    'Důvod doporučení': 'Recommendation Reason',
}

# Fixed set of module categories as (title, description), in this exact order.
# They're seeded into the database in this order before any course import runs,
# so their auto-increment id (1-7) matches this list's position deterministically -
# instead of being created ad hoc from whatever raw Excel "Category" text (or lack
# of it) each course happens to have.
MODULE_CATEGORIES = [
    ("I discover", "Self-Discovery & Inner Strength"),
    ("I care myself", "Self-Care & Resilience"),
    ("I'm confident", "Confidence & Communication"),
    ("I'm leader", "Leadership & Personal Growth"),
    ("I connect", "Connection & Community"),
    ("I'm inspired", "Inspiration & Role Models"),
    ("I catch up", "Tech & AI"),
]

# Which fixed category each course belongs to, keyed by exact course title.
# Value is 1-indexed into MODULE_CATEGORIES above.
CATEGORY_OVERRIDES = {
    "Discover your inner potential": 1,
    "Discover Your Personality: The Big Five Model": 1,
    "Ikigai: Discover your purpose": 2,
    "Story of me: Rewriting your power narrative": 2,
    "Self-Care for Strong Leaders": 2,
    "Breathwork for Focus and Balance": 2,
    "Mindful Meditation Moments": 2,
    "Unlocking Creativity & Vision": 2,
    "Get ready for public speaking": 3,
    "Public speaking - staying strong in the spotlight": 3,
    "Digital Courage: Setting Boundaries & Showing Up Safely Online": 3,
    "Personal Brand Building: Lead With Your Story": 3,
    "Strategies and Tools to Strengthen Self-Confidence": 4,
    "Knowing Yourself as a Leader - Leading your own way": 4,
    "Proactive Leadership in Daily Life": 4,
    "Believing in Your Growth": 4,
    "Designing Your Growth Path": 4,
    "Vision, Confidence & Moving Forward": 4,
    "Networking: Building Real, Warm Connections": 5,
    "Partnering: The Power of Building Things with Others": 5,
    "How to speak to gain allies for your actions?": 5,
    "Thankfulness: The Quiet Psychological Relief": 5,
    "Motivational Techniques for Daily Life": 5,
    "React to discrimination – don’t be indifferent": 5,
    "Empowerment to... But what does power mean?": 6,
    "„I want to understand.“ - HANNAH ARENDT": 6,
    "Pioneer of Computer Science - ADA LOVELACE ": 6,
    "Silent Heros: The power of listening and the liberation of time": 6,
    "Day 5: Rebiya Kadeer — Staying Strong Under Pressure": 6,
    "A Brief Use of AI: What You Can Actually Do With It": 7,
}
