# Import pandas to read Excel files
# Import traceback to display detailed error information
# Import os to construct paths
# Import all maps from /utils/excel_mapping.py
import pandas as pd
import traceback
import os
from .excel_mapping import *

# Function to construct the path - data abstraction
# - data_type: type of the data -> course or simulator
# - filename: name of the file where data is located
# Returns: the path created based on data type
def get_file_path(data_type, filename):
    if data_type not in FOLDER_MAP:
        raise ValueError(f"Unknown data type: {data_type}.")

    current_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(current_dir, "../../"))
    folder = FOLDER_MAP[data_type]
    file_path = os.path.join(project_root, 'data-sources', folder, filename)
    return file_path

# Function to split comma-separated strings - data encapsulation
# - text: text with commas to split -> tags, metrics, etc.
# Returns: list of cleaned strings
def parse_comma_list(text):
    if not text: return []
    return [item.strip() for item in str(text).split(",") if item.strip()]

# Function to check if content is a placeholder (just "-" or "x") - data validation
# - content: the raw value from Excel cell
# Returns: True if content is ONLY "-" or "x", False otherwise
def is_placeholder(content):
    """
    Check if content is a placeholder that should be ignored.
    Users sometimes use "-" or "x" instead of leaving cells empty.
    This function returns True only if the ENTIRE content is ONLY "-" or "x" (case-insensitive)
    """
    if content is None or (isinstance(content, float) and pd.isna(content)):
        return False

    cleaned = str(content).strip().lower()
    return cleaned in ["-", "x"]

# Function to clean and validate Excel content - data encapsulation
# - content: the raw value from Excel cell
# Returns: cleaned string or None if empty or placeholder
def clean_content(content):
    if pd.isna(content) or str(content).strip() == "" or str(content).strip().lower() == "nan":
        return None
    # Check if content is a placeholder like "-" or "x"
    if is_placeholder(content):
        return None
    return str(content).strip()

# Function to safely convert a value to integer - error handling
# - value: the value to convert
# - default: default value if conversion fails (default: None)
# - silent: if True, don't print warning messages (default: True)
# Returns: integer value or default if conversion fails
def safe_int(value, default=None, silent=True):
    if value is None or (isinstance(value, float) and pd.isna(value)):
        return default
    try:
        return int(float(value))
    except (ValueError, TypeError):
        # Silently handle non-numeric values like 'x', 'X', or other placeholders
        if not silent and str(value).strip().lower() not in ['x', 'n/a', 'na', '-']:
            print(f"WARNING: Could not convert '{value}' to integer. Using NULL instead.")
        return default

# Function to load data from Excel files
# - data_type: type of the data -> course or simulator (can be None if full_path is provided)
# - filename: name of the file where data is located (can be None if full_path is provided)
# - full_path: optional full path to the file (if provided, ignores data_type and filename)
def load_data(data_type=None, filename=None, full_path=None):
    # If full_path is provided, use it directly
    if full_path:
        file_path = full_path
        display_name = os.path.basename(full_path)
    else:
        # Otherwise, construct path from data_type and filename
        if not data_type or not filename:
            raise ValueError("Either full_path or both data_type and filename must be provided")
        file_path = get_file_path(data_type, filename)
        display_name = filename

    print(f"Loading {display_name}...")

    try:
        df = pd.read_excel(file_path, sheet_name=None)
        print(f"Data loaded - {len(df)} sheet(s) found")
        # print(df.head()) # to show a part of the content
        print(f"   Sheets: {list(df.keys())}")
        return df
    except Exception as e:
        print(f"ERROR: Failed to load {display_name}")
        traceback.print_exc()
        return None

# Function to transform an Excel row into a dictionary with data for database - data abstraction
# - df_row: a row from Excel sheet
# - mapping_dict: dictionary from excel_mapping.py
# Returns: dictionary ready to be used
def map_excel_to_db(df_row, mapping_dict) :
    data_for_db = {}
    for excel_col, db_col in mapping_dict.items():
        if excel_col in df_row:
            data_for_db[db_col] = df_row[excel_col]

    return data_for_db


# Function to get the "Example content" value by position rather than header name
# - row: the full dataframe row
# Returns: raw value of the column right after "Field", regardless of its header text
def get_example_content_value(row):
    """
    Some templates repurpose the "Example content" header (e.g. embedding the
    course/day name in it), while keeping content in the same position - the
    column right after "Field". Reading positionally makes card parsing
    resilient to that instead of silently returning nothing.
    """
    if len(row) > 1:
        return row.iloc[1]
    return None

# Function to extract all dynamic option columns from a row
# - row: the full dataframe row
# Returns: list of cleaned option values in order
def extract_all_options(row):
    """
    Dynamically extract all options from columns like Option A, Option B, Option C, etc.
    Handles options from A to Z and beyond (A-Z, AA, AB, etc.)
    Returns options in order, skipping empty cells
    """
    options = []
    # Try all possible option columns (Option A through Option Z)
    for letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ':
        opt_val = clean_content(row.get(f"Option {letter}"))
        if opt_val:
            options.append(opt_val)
        else:
            # Stop if we hit a gap (assume options are continuous)
            if len(options) > 0:
                break
    return options


# Function to format component data based on mapping - data encapsulation
# - field_name: the name of the field from Excel
# - content: the cleaned content
# - row: the full dataframe row (needed for MCQ options and List content)
# Returns: a dictionary with component info or None
def get_component_info(field_name, content, row):
    if field_name not in COMPONENTS_TABLES_MAP:
        return None

    mapping = COMPONENTS_TABLES_MAP[field_name]
    comp_data = {
        "table": mapping["table"],
        "column": mapping["column"],
        "content": content,
        "type_enum": mapping["enum"],
        "fields": {}
    }
    # Specific logic for image
    if field_name == "Image":
        comp_data["fields"]["image_alt"] = clean_content(row.get("Image Alt"))
        comp_data["fields"]["image_description"] = clean_content(row.get("Image Description"))
    # Specific logic for video
    elif field_name == "Video":
        comp_data["fields"]["video_duration_est"] = clean_content(row.get("Video Duration Est"))
        comp_data["fields"]["video_alt"] = clean_content(row.get("Video Alt"))
        comp_data["fields"]["video_description"] = clean_content(row.get("Video Description"))
    # Specific logic for quote
    elif field_name == "Quote":
        comp_data["fields"]["author"] = clean_content(row.get("Author"))
    # Specific logic for MCQ - dynamic options
    elif field_name == "Multiple choice question":
        options = extract_all_options(row)
        comp_data["options"] = options
    # Specific logic for List - dynamic options
    elif field_name == "List":
        # For List components, use "Example content" as the intro/first element
        example_content = clean_content(get_example_content_value(row))
        # Extract all options as list items
        list_items = extract_all_options(row)
        # If Example content is provided, prepend it or use it as content
        comp_data["content"] = example_content if example_content else None
        comp_data["list_items"] = list_items

    return comp_data


# Function to extract data for card table and components tables
# - df_card: dataframe of the card sheet
# - card_index: order of the card
# Returns: card_info and list of components
def extract_full_card_data(df_card, card_index):
    # Data for card table
    card_info = {
        "owner_type": "module",
        "owner_id": None,
        "card_order_index": card_index,
        "title": None,
        "subtitle": None,
        "end_text": None,
        "why_this_question": None
    }

    # List to save components to create
    components_to_create = []

    for index, row in df_card.iterrows():
        field_name = str(row['Field']).strip()
        content = clean_content(get_example_content_value(row))

        # If for a field, content is not empty (for card field)
        if field_name in ["Title", "Card Title"]:
            card_info["title"] = content
        elif field_name in ["Subtitle", "Card Subtitle"]:
            card_info["subtitle"] = content
        elif field_name == "End_text":
            card_info["end_text"] = content
        elif field_name == "Why This Question":
            card_info["why_this_question"] = content

        # Component info extraction by using the encapsulation function
        component = get_component_info(field_name, content, row)
        if component:
            components_to_create.append(component)

    return card_info, components_to_create

# Function to extract data for card table from the simulator sheet - data encapsulation
# - df_cards: dataframe of the cards sheet
# Returns: card info
def extract_simulator_cards(df_cards):
    cards = []
    for _, row in df_cards.iterrows():
        order = clean_content(row.get('Card Order'))
        if not order: continue

        card_data = {
            "info": {
                "owner_type": "simulator",
                "card_order_index": safe_int(order),
                "title": clean_content(row.get('Title')),
                "subtitle": clean_content(row.get('Subtitle')),
                "end_text": clean_content(row.get('End_text')),
                "why_this_question": clean_content(row.get('Why This Question'))
            },
            "components": []
        }

        visual_url = clean_content(row.get('Visual Description (link) or other'))
        if visual_url:
            # If image or video
            comp_type = "video" if "youtube" in visual_url or "vimeo" in visual_url else "image"
            col_name = "video_url" if comp_type == "video" else "image_url"

            card_data["components"].append({
                "type": comp_type,
                "table": f"component_{comp_type}",
                "column": col_name,
                "content": visual_url,
                "fields": {
                    f"{comp_type}_alt": clean_content(row.get('Image Alt' if comp_type == "image" else 'Video Alt')),
                    f"{comp_type}_description": clean_content(
                        row.get('Image Description' if comp_type == "image" else 'Video Description'))
                }
            })

        situation = clean_content(row.get('Situation Text'))
        if situation:
            card_data["components"].append({"type": "text", "content": situation})

        # Dynamically extract all action options (Action 1, Action 2, Action 3, etc.)
        # This replaces the hardcoded loop for actions 1-3
        options = []
        action_num = 1
        while True:
            action_text = clean_content(row.get(f'Action {action_num} Text'))
            if not action_text:
                break

            option_data = {
                "text": action_text,
                "feedback": clean_content(row.get(f'Action {action_num} Feedback')),
                "weights": parse_metric_effects(row.get(f'Action {action_num} Metric Effects'))
            }
            options.append(option_data)
            action_num += 1

        # Only add MCQ component if at least one action was found
        if options:
            card_data["components"].append({
                "type": "mcq",
                "content": situation,
                "options": options
            })

        cards.append(card_data)
    return cards

# Function to parse string metric into a dictionary to let repository.py understand - data encapsulation
# - effect_string: raw string from Excel -> "Authority +20, Clarity -10"
# Returns: dictionary where key are metric names and values are integers
def parse_metric_effects(effect_string):
    effects = {}
    if not effect_string: return effects

    # Split by comma
    parts = str(effect_string).split(",")
    for part in parts:
        part = part.strip()
        if " " in part:
            name = part.rsplit(" ", 1)[0].strip()
            value = part.rsplit(" ", 1)[1].strip()
            converted_value = safe_int(value)
            if converted_value is not None:
                effects[name] = converted_value
    return effects

# Function to extract overall results for the simulator
# - df_overall: dataframe of the overall result sheet
# Returns: list of dictionaries with score range and their titles
def extract_simulator_overall_results(df_overall):
    results = []
    for _, row in df_overall.iterrows():
        range_val = clean_content(row.get("Score Range (<50 / 50-85 / 85-100)"))
        if range_val:
            results.append({
                "score_range": range_val,
                "title": clean_content(row.get("One-Sentence Result Title"))
            })
    return results

# Data abstraction:
# The aim is to hide the complexity of code behind a function.
# In this way, the main function doesn't need to know in detail how a path is formed, for example.

# Data encapsulation:
# The aim is to regroup logic into a function instead of using a lot of if/else blocks.
# In this way, if the logic changes, we can change it only in the function without having to change it in each if/else block.
