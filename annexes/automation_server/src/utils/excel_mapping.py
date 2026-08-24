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
