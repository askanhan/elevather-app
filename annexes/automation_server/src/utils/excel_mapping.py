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
