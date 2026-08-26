# Module to generate SQL queries from Excel data without executing them

from datetime import datetime
from .excel_loader import (
    load_data, map_excel_to_db, clean_content, extract_full_card_data,
    extract_simulator_cards, parse_comma_list, safe_int
)
from .excel_mapping import (
    MODULE_TABLE_MAP, SIMULATOR_TABLE_MAP, DAY_NUMBER_OVERRIDES, TITLE_OVERRIDES,
    CATEGORY_OVERRIDES, MODULE_CATEGORIES
)


def find_overview_sheet(df_dict, sheet_type="course"):
    """
    Find the overview/overview sheet regardless of exact name.
    For courses: looks for "Overview", "Course Overview", "Module" in sheet name
    For simulators: looks for "Overview", "Simulator Overview" in sheet name
    Returns the sheet name and the dataframe row
    """
    sheet_names = list(df_dict.keys())

    # Define search patterns for each sheet type
    if sheet_type == "course":
        patterns = ["overview", "course overview", "module"]
    else:  # simulator
        patterns = ["overview", "simulator overview"]

    # Look for sheets matching patterns (case insensitive)
    for pattern in patterns:
        overview_sheets = [s for s in sheet_names if pattern in s.lower()]
        if overview_sheets:
            overview_sheet_name = overview_sheets[0]
            return overview_sheet_name, df_dict[overview_sheet_name]

    raise ValueError(f"No Overview sheet found for {sheet_type}. Available sheets: {sheet_names}")


def find_overview_row(overview_df, sheet_type="course"):
    """
    Find the first row in the overview sheet that has real data, skipping
    instructional/placeholder rows some templates leave between the header
    and the actual filled-in row (identified by the title cell being empty).
    Falls back to the first row if no row has a title, so callers see the
    same "missing title" error as before instead of failing silently.
    """
    title_column = "Course Title" if sheet_type == "course" else "Simulator Title"

    for _, row in overview_df.iterrows():
        if clean_content(row.get(title_column)):
            return row

    return overview_df.iloc[0]


def escape_sql_string(value):
    """
    Escape single quotes in SQL strings and handle special characters for TEXT columns :
    - value: the string value to escape
    """
    if value is None:
        return "NULL"
    if isinstance(value, (int, float)):
        return str(value)
    # Convert to string and escape single quotes (double them)
    # Also handle newlines and special characters for long text values
    string_value = str(value)
    # Escape single quotes
    string_value = string_value.replace("'", "''")
    return f"'{string_value}'"


def build_insert_query(table_name, columns, values):
    """
    Build an INSERT SQL query :
    - table_name: name of the table to insert into
    - columns: list of column names
    - values: list of corresponding values (will be escaped)
    """
    cols = ", ".join(columns)
    vals = ", ".join([escape_sql_string(v) for v in values])
    return f"INSERT INTO {table_name} ({cols}) VALUES ({vals});"


def build_select_query(table_name, where_column, where_value):
    """
    Build a SELECT SQL query :
    - table_name: name of the table to select from
    - where_column: column name for the WHERE clause
    - where_value: value for the WHERE clause (will be escaped)
    """
    return f"SELECT id FROM {table_name} WHERE {where_column} = {escape_sql_string(where_value)};"


def generate_category_query(title, description="Default description"):
    """
    Generate queries for module category (get or create) :
    - title: category title
    - description: category description (default: "Default description")
    """
    queries = []
    # First check if exists, if not create it
    queries.append(f"-- Check/Create category '{title}'")
    queries.append(f"INSERT IGNORE INTO module_category (title, description, created_at) VALUES ({escape_sql_string(title)}, {escape_sql_string(description)}, {escape_sql_string(datetime.now())});")
    return queries


def generate_module_query(category_title, day, title, description, target_audience=None, estimated_duration=None):
    """
    Generate query for module creation using subquery for category :
    - category_title: title of the category (used in subquery to find category_id)
    - day: day number for the module
    - title: module title
    - description: module description
    - target_audience: target audience for the module (optional)
    - estimated_duration: estimated duration in minutes (optional)
    """
    cols = ["module_category_id", "day_number", "title", "description", "target_audience", "estimated_duration", "created_at"]
    vals = [
        f"(SELECT id FROM module_category WHERE title = {escape_sql_string(category_title)})",
        day,
        title,
        description,
        target_audience,
        estimated_duration,
        datetime.now()
    ]

    cols_str = ", ".join(cols)
    vals_str = ", ".join([escape_sql_string(v) if not str(v).startswith("(SELECT") else str(v) for v in vals])
    return f"INSERT INTO module ({cols_str}) VALUES ({vals_str});"


def generate_simulator_query(title, description, level, localisation, duration):
    """
    Generate query for simulator creation :
    - title: simulator title
    - description: simulator description
    - level: simulator level (e.g., "intro", "intermediate", "advanced")
    - localisation: simulator localisation (e.g., "remote", "in-person")
    - duration: estimated duration in minutes
    """
    return build_insert_query(
        "simulator",
        ["title", "description", "level", "localisation", "estimated_duration", "created_at"],
        [title, description, level, localisation, duration, datetime.now()]
    )


def generate_card_query(owner_type, owner_id_query, order, title=None, subtitle=None, end_text=None, why_this_question=None):
    """
    Generate query for card creation using subquery for owner_id :
    - owner_type: type of the owner entity (e.g., "module", "simulator")
    - owner_id_query: subquery to find the owner ID (e.g., "(SELECT id FROM module WHERE title = 'Module 1')")
    - order: card order index within the owner
    - title: card title (optional)
    - subtitle: card subtitle (optional)
    - end_text: card end text (optional)
    - why_this_question: explanation for why this question is asked (optional)
    """
    cols = ["owner_type", "owner_id", "card_order_index", "title", "subtitle", "end_text", "why_this_question"]
    vals = [owner_type, owner_id_query, order, title, subtitle, end_text, why_this_question]

    cols_str = ", ".join(cols)
    vals_str = ", ".join([escape_sql_string(v) if not str(v).startswith("(SELECT") else str(v) for v in vals])
    return f"INSERT INTO card ({cols_str}) VALUES ({vals_str});"


def generate_simple_component_query(table_name, fields):
    """
    Generate query for simple component creation :
    - table_name: name of the component table (e.g., "component_text")
    - fields: dictionary of column names and their corresponding values for the component
    """
    columns = list(fields.keys())
    values = list(fields.values())
    return build_insert_query(table_name, columns, values)


def generate_mcq_query(question_text):
    """
    Generate query for MCQ component creation :
    - question_text: the text of the MCQ question
    """
    return build_insert_query(
        "component_mcq",
        ["question"],
        [question_text]
    )


def generate_mcq_option_query(mcq_question, option_text, feedback=None):
    """
    Generate query for MCQ option using subquery to get the MCQ ID by question :
    - mcq_question: the text of the MCQ question (used in subquery to find mcq_id)
    - option_text: the text of the MCQ option
    - feedback: optional feedback for the option (if provided, included in the query)
    """
    if feedback:
        cols = ["mcq_id", "option_text", "feedback"]
        # Use subquery to find MCQ by question instead of LAST_INSERT_ID()
        mcq_id_subquery = f"(SELECT id FROM component_mcq WHERE question = {escape_sql_string(mcq_question)} ORDER BY id DESC LIMIT 1)"
        vals = [mcq_id_subquery, option_text, feedback]
    else:
        cols = ["mcq_id", "option_text"]
        # Use subquery to find MCQ by question instead of LAST_INSERT_ID()
        mcq_id_subquery = f"(SELECT id FROM component_mcq WHERE question = {escape_sql_string(mcq_question)} ORDER BY id DESC LIMIT 1)"
        vals = [mcq_id_subquery, option_text]

    cols_str = ", ".join(cols)
    # Escape values but keep subqueries unescaped
    escaped_vals = []
    for v in vals:
        if str(v).startswith("(SELECT"):
            escaped_vals.append(str(v))
        else:
            escaped_vals.append(escape_sql_string(v))

    vals_str = ", ".join(escaped_vals)
    return f"INSERT INTO multiple_choices_options ({cols_str}) VALUES ({vals_str});"


def generate_link_component_query(card_id_query, comp_type, order, comp_id_query):
    """
    Generate query for linking component to card with subqueries :
    - card_id_query: subquery to find the card ID (e.g., "(SELECT id FROM card WHERE title = 'Card 1')")
    - comp_type: type of the component (e.g., "text", "image", "mcq")
    - order: component order index within the card
    - comp_id_query: subquery to find the component ID (e.g., "LAST_INSERT_ID()" or a specific subquery if needed)
    """
    cols = ["card_id", "component_type", "component_order_index", "component_id"]
    vals = [card_id_query, comp_type, order, comp_id_query]

    cols_str = ", ".join(cols)
    # Special handling: if comp_id_query is LAST_INSERT_ID(), don't escape it
    escaped_vals = []
    for v in vals:
        if v == "LAST_INSERT_ID()" or str(v).startswith("(SELECT"):
            escaped_vals.append(str(v))
        else:
            escaped_vals.append(escape_sql_string(v))

    vals_str = ", ".join(escaped_vals)
    return f"INSERT INTO card_contains ({cols_str}) VALUES ({vals_str});"


def generate_module_tag_query(tag_title):
    """
    Generate query for module tag creation :
    - tag_title: title of the module tag
    """
    return build_insert_query(
        "module_tag",
        ["title", "created_at"],
        [tag_title, datetime.now()]
    )


def generate_link_module_tag_query(module_id_query, tag_title):
    """
    Generate query for linking module to tag using subqueries :
    - module_id_query: subquery to find the module ID (e.g., "(SELECT id FROM module WHERE title = 'Module 1')")
    - tag_title: title of the module tag (used in subquery to find module_tag_id)
    """
    return f"INSERT INTO module_contains_tags (module_id, module_tag_id) VALUES ({module_id_query}, (SELECT id FROM module_tag WHERE title = {escape_sql_string(tag_title)} LIMIT 1));"


def generate_simulator_tag_query(tag_name):
    """
    Generate query for simulator tag creation :
    - tag_name: name of the simulator tag
    """
    return build_insert_query(
        "simulator_tag",
        ["name"],
        [tag_name]
    )


def generate_link_simulator_tag_query(simulator_id_query, tag_name):
    """
    Generate query for linking simulator to tag using subqueries :
    - simulator_id_query: subquery to find the simulator ID (e.g., "(SELECT id FROM simulator WHERE title = 'Simulator 1')")
    - tag_name: name of the simulator tag (used in subquery to find simulator_tag_id)
    """
    return f"INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ({simulator_id_query}, (SELECT id FROM simulator_tag WHERE name = {escape_sql_string(tag_name)} LIMIT 1));"


def generate_simulator_metric_query(metric_name):
    """
    Generate query for simulator metric creation :
    - metric_name: name of the simulator metric
    """
    return build_insert_query(
        "simulator_metric",
        ["name"],
        [metric_name]
    )


def generate_link_simulator_metric_query(simulator_id_query, metric_name):
    """
    Generate query for linking simulator to metric using subqueries :
    - simulator_id_query: subquery to find the simulator ID (e.g., "(SELECT id FROM simulator WHERE title = 'Simulator 1')")
    - metric_name: name of the simulator metric (used in subquery to find simulator_metric_id)
    """
    return f"INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ({simulator_id_query}, (SELECT id FROM simulator_metric WHERE name = {escape_sql_string(metric_name)} LIMIT 1));"


def generate_mcq_weight_query(mcq_question, option_text, metric_name, weight):
    """
    Generate query for MCQ option weights using subqueries to find option by MCQ question + option text
    """
    # Use a subquery to find the option ID by matching:
    # 1. The MCQ question (to find the MCQ)
    # 2. The option text (to find the specific option)
    option_id_subquery = f"""(SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = {escape_sql_string(mcq_question)}) 
     AND option_text = {escape_sql_string(option_text)} 
     ORDER BY id DESC LIMIT 1)"""

    return f"INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ({option_id_subquery}, (SELECT id FROM simulator_metric WHERE name = {escape_sql_string(metric_name)} LIMIT 1), {weight});"



def generate_feedback_query(simulator_id_query, metric_name, min_s, max_s, strength, risk, micro_practice, recommended_module_id, recommendation_reason):
    """
    Generate query for simulator feedback tier using subqueries
    """
    return f"INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ({simulator_id_query}, (SELECT id FROM simulator_metric WHERE name = {escape_sql_string(metric_name)} LIMIT 1), {min_s}, {max_s}, {escape_sql_string(strength)}, {escape_sql_string(risk)}, {escape_sql_string(micro_practice)}, {escape_sql_string(recommended_module_id)}, {escape_sql_string(recommendation_reason)});"


def save_queries_to_file(filename, queries):
    """
    Save list of SQL queries to a file :
    - filename: path to the output file
    - queries: list of SQL query strings to save
    """
    with open(filename, 'w', encoding='utf-8') as f:
        f.write("-- ============================================\n")
        f.write(f"-- SQL Queries Generated on {datetime.now()}\n")
        f.write("-- ============================================\n")
        f.write("-- These queries can be copied and executed directly\n")
        f.write("-- Subqueries are used to automatically resolve IDs\n")
        f.write("-- ============================================\n\n")

        for query in queries:
            f.write(query + "\n")

        f.write("\n-- ============================================\n")
        f.write("-- End of generated queries\n")
        f.write("-- ============================================\n")

    print(f"Queries saved to: {filename}")
    return filename




def generate_sql_course(file_info, output_file=None):
    """
    Generate SQL queries from course Excel file.
    - file_info (dict or str): File info dict with 'filename', 'relative_path', 'full_path'
                                OR just filename string for backward compatibility
    - output_file (str): Optional output file path for SQL queries
    """
    # Handle both dict (from discover_excel_files) and string (legacy)
    if isinstance(file_info, dict):
        display_name = file_info.get('relative_path', file_info.get('filename', 'Unknown'))
        full_path = file_info.get('full_path')
        filename = file_info.get('filename', 'Unknown')
    else:
        display_name = file_info
        full_path = None
        filename = file_info

    print(f"\n--- Generating SQL queries from Course: {display_name} ---")

    queries = []

    # 1. load excel file
    course_df = load_data(full_path=full_path) if full_path else load_data("course", filename)
    if not course_df:
        return queries

    # 2. overview sheet - find it dynamically
    try:
        overview_sheet_name, overview_df = find_overview_sheet(course_df, sheet_type="course")
        overview_row = find_overview_row(overview_df, sheet_type="course")
    except ValueError as e:
        print(f"ERROR: {str(e)}")
        return queries

    module_data = map_excel_to_db(overview_row, MODULE_TABLE_MAP)
    module_data['title'] = TITLE_OVERRIDES.get(filename, module_data['title'])

    category_index = CATEGORY_OVERRIDES.get(module_data['title'])
    if category_index is not None:
        category_name, category_description = MODULE_CATEGORIES[category_index - 1]
    else:
        category_name = clean_content(overview_row.get("Category"))
        if not category_name:
            category_name = "General"
            print(f"WARNING: Category is empty. Using default category: 'General'")
        category_description = "test description"

    queries.append(f"\n-- ============================================")
    queries.append(f"-- Course: {module_data['title']}")
    queries.append(f"-- ============================================")

    # Generate category queries (with INSERT IGNORE for existing)
    queries.append(f"\n-- Category: {category_name}")
    queries.extend(generate_category_query(category_name, category_description))

    # Generate module query with subquery for category_id
    queries.append(f"\n-- Module creation with automatic category lookup")
    day_number = DAY_NUMBER_OVERRIDES.get(module_data['title'], safe_int(module_data['day_number'], 1))
    queries.append(generate_module_query(
        category_name,  # Will be used in subquery
        day_number,
        module_data['title'],
        module_data['description'],
        module_data.get('target_audience'),
        safe_int(module_data.get('estimated_duration'), 0)
    ))

    # Generate tag queries
    tags = parse_comma_list(overview_row.get("Tags (comma separated)"))
    if tags:
        queries.append(f"\n-- Module Tags")
        for tag in tags:
            queries.append(generate_module_tag_query(tag))

    # Link tags to module using subquery
    if tags:
        for tag in tags:
            queries.append(generate_link_module_tag_query(
                f"(SELECT LAST_INSERT_ID())",  # The module we just created
                tag
            ))

    # 3. cards
    card_count = 1
    for sheet_name, df_sheet in course_df.items():
        if "Card" in sheet_name:
            queries.append(f"\n-- ============================================")
            queries.append(f"-- Card {card_count}")
            queries.append(f"-- ============================================")

            # Extract card info
            card_attr, components = extract_full_card_data(df_sheet, card_count)

            # Generate card query with subquery for module_id
            queries.append(generate_card_query(
                'module',
                f"(SELECT id FROM module WHERE title = {escape_sql_string(module_data['title'])})",
                card_count,
                card_attr['title'], card_attr['subtitle'],
                card_attr['end_text'], card_attr['why_this_question']
            ))

            component_order = 1
            # Generate component queries
            for comp in components:
                if comp['content'] is None:
                    continue

                queries.append(f"\n-- Component {component_order} for Card {card_count}")

                if comp['table'] == 'component_mcq':
                    queries.append(generate_mcq_query(comp['content']))

                    # Loop through all available options dynamically
                    if comp.get('options'):
                        for opt_idx, option in enumerate(comp['options']):
                            queries.append(generate_mcq_option_query(
                                comp['content'],  # MCQ question
                                option
                            ))

                    queries.append(generate_link_component_query(
                        f"(SELECT id FROM card WHERE title = {escape_sql_string(card_attr['title'])} AND owner_id = (SELECT id FROM module WHERE title = {escape_sql_string(module_data['title'])}) LIMIT 1)",
                        comp['type_enum'],
                        component_order,
                        "LAST_INSERT_ID()"
                    ))
                elif comp['table'] == 'component_list':
                    # Handle LIST component - each item is a separate row in component_list
                    # with its own card_contains link
                    current_item_order = component_order

                    # Insert intro/title as first list item if provided
                    if comp['content']:
                        queries.append(f"\n-- List item {current_item_order}: {comp['content'][:50]}...")
                        all_component_data = {comp['column']: comp['content']}
                        queries.append(generate_simple_component_query(comp['table'], all_component_data))

                        queries.append(generate_link_component_query(
                            f"(SELECT id FROM card WHERE title = {escape_sql_string(card_attr['title'])} AND owner_id = (SELECT id FROM module WHERE title = {escape_sql_string(module_data['title'])}) LIMIT 1)",
                            comp['type_enum'],
                            current_item_order,
                            "LAST_INSERT_ID()"
                        ))
                        current_item_order += 1

                    # Insert each list item as separate row in component_list
                    if comp.get('list_items'):
                        for item_idx, list_item in enumerate(comp['list_items']):
                            if list_item:  # Only insert non-empty items
                                queries.append(f"\n-- List item {current_item_order}: {list_item[:50]}...")
                                item_data = {comp['column']: list_item}
                                queries.append(generate_simple_component_query(comp['table'], item_data))

                                queries.append(generate_link_component_query(
                                    f"(SELECT id FROM card WHERE title = {escape_sql_string(card_attr['title'])} AND owner_id = (SELECT id FROM module WHERE title = {escape_sql_string(module_data['title'])}) LIMIT 1)",
                                    comp['type_enum'],
                                    current_item_order,
                                    "LAST_INSERT_ID()"
                                ))
                                current_item_order += 1

                    # Update the component_order for next component
                    component_order = current_item_order - 1
                else:
                    all_component_data = {comp['column']: comp['content']}
                    if comp.get('fields'):
                        all_component_data.update(comp['fields'])

                    queries.append(generate_simple_component_query(comp['table'], all_component_data))

                    queries.append(generate_link_component_query(
                        f"(SELECT id FROM card WHERE title = {escape_sql_string(card_attr['title'])} AND owner_id = (SELECT id FROM module WHERE title = {escape_sql_string(module_data['title'])}) LIMIT 1)",
                        comp['type_enum'],
                        component_order,
                        "LAST_INSERT_ID()"
                    ))

                component_order += 1

            card_count += 1

    # Save to file if output_file is specified
    if output_file:
        save_queries_to_file(output_file, queries)

    return queries


def generate_sql_simulator(file_info, output_file=None):
    """
    Generate SQL queries from simulator Excel file.
    - file_info (dict or str): File info dict with 'filename', 'relative_path', 'full_path'
                                OR just filename string for backward compatibility
    - output_file (str): Optional output file path for SQL queries
    """
    # Handle both dict (from discover_excel_files) and string (legacy)
    if isinstance(file_info, dict):
        display_name = file_info.get('relative_path', file_info.get('filename', 'Unknown'))
        full_path = file_info.get('full_path')
        filename = file_info.get('filename', 'Unknown')
    else:
        display_name = file_info
        full_path = None
        filename = file_info

    print(f"\n--- Generating SQL queries from Simulator: {display_name} ---")

    queries = []

    # 1. load excel file
    sim_df = load_data(full_path=full_path) if full_path else load_data("simulator", filename)
    if not sim_df:
        return queries

    # 2. overview sheet - find it dynamically
    try:
        overview_sheet_name, overview_df = find_overview_sheet(sim_df, sheet_type="simulator")
        overview_row = find_overview_row(overview_df, sheet_type="simulator")
    except ValueError as e:
        print(f"ERROR: {str(e)}")
        return queries

    sim_data = map_excel_to_db(overview_row, SIMULATOR_TABLE_MAP)

    queries.append(f"\n-- ============================================")
    queries.append(f"-- Simulator: {sim_data['title']}")
    queries.append(f"-- ============================================")

    # Generate simulator query
    queries.append(generate_simulator_query(
        sim_data['title'],
        overview_row.get('Description', 'No description'),
        sim_data.get('level', 'intro').lower(),
        sim_data.get('localisation'),
        safe_int(sim_data['estimated_duration'], 0) if sim_data.get('estimated_duration') else 0
    ))

    # Generate tag queries
    tags = parse_comma_list(overview_row.get("Tags (comma separated)"))
    if tags:
        queries.append(f"\n-- Simulator Tags")
        for tag in tags:
            queries.append(generate_simulator_tag_query(tag))
            # Link tags to simulator using subquery
            queries.append(generate_link_simulator_tag_query(
                f"(SELECT id FROM simulator WHERE title = {escape_sql_string(sim_data['title'])})",
                tag
            ))

    # Generate metric queries
    metrics = parse_comma_list(overview_row.get("Metrics (comma separated)"))
    if metrics:
        queries.append(f"\n-- Simulator Metrics")
        for metric_name in metrics:
            queries.append(generate_simulator_metric_query(metric_name))
            # Link metrics to simulator using subquery
            queries.append(generate_link_simulator_metric_query(
                f"(SELECT id FROM simulator WHERE title = {escape_sql_string(sim_data['title'])})",
                metric_name
            ))

    # 3. cards
    cards_sheet = sim_df.get("Cards")
    if cards_sheet is not None:
        simulator_cards = extract_simulator_cards(cards_sheet)

        for i, card_data in enumerate(simulator_cards):
            card_info = card_data["info"]

            queries.append(f"\n-- ============================================")
            queries.append(f"-- Card {card_info['card_order_index']}")
            queries.append(f"-- ============================================")

            queries.append(generate_card_query(
                'simulator',
                f"(SELECT id FROM simulator WHERE title = {escape_sql_string(sim_data['title'])})",
                card_info['card_order_index'],
                card_info['title'],
                card_info['subtitle'],
                card_info['end_text'],
                card_info['why_this_question']
            ))

            comp_order = 1
            for comp in card_data["components"]:
                # Skip components with no content (placeholders like "-" or "x" are converted to None)
                if comp.get('content') is None:
                    continue

                queries.append(f"\n-- Component {comp_order} for Card {i}")

                if comp['type'] in ['image', 'video', 'text']:
                    all_fields = {comp.get('column', 'content'): comp['content']}
                    if comp.get('fields'):
                        all_fields.update(comp['fields'])

                    queries.append(generate_simple_component_query(
                        comp.get('table', 'component_text'),
                        all_fields
                    ))

                    queries.append(generate_link_component_query(
                        f"(SELECT id FROM card WHERE title = {escape_sql_string(card_info['title'])} AND owner_id = (SELECT id FROM simulator WHERE title = {escape_sql_string(sim_data['title'])}) LIMIT 1)",
                        comp['type'],
                        comp_order,
                        "LAST_INSERT_ID()"
                    ))

                elif comp['type'] == 'mcq':
                    queries.append(generate_mcq_query(comp['content']))

                    for opt_idx, option in enumerate(comp['options']):
                        opt_text = option.get('text') if isinstance(option, dict) else option
                        opt_feedback = option.get('feedback') if isinstance(option, dict) else None

                        queries.append(generate_mcq_option_query(
                            comp['content'],  # MCQ question
                            opt_text,
                            opt_feedback
                        ))

                        # Handle weights if present
                        if isinstance(option, dict) and option.get('weights'):
                            for metric_name, weight in option['weights'].items():
                                queries.append(generate_mcq_weight_query(
                                    comp['content'],  # MCQ question
                                    opt_text,  # Option text
                                    metric_name,
                                    weight
                                ))

                    queries.append(generate_link_component_query(
                        f"(SELECT id FROM card WHERE title = {escape_sql_string(card_info['title'])} AND owner_id = (SELECT id FROM simulator WHERE title = {escape_sql_string(sim_data['title'])}) LIMIT 1)",
                        comp['type'],
                        comp_order,
                        "LAST_INSERT_ID()"
                    ))

                comp_order += 1

        # 4. feedback
        feedback_sheet = sim_df.get("Metric Writing")
        if feedback_sheet is not None:
            queries.append(f"\n-- ============================================")
            queries.append(f"-- Feedback Tiers")
            queries.append(f"-- ============================================")

            for _, row in feedback_sheet.iterrows():
                metric_name = clean_content(row.get("Metric Name"))
                if not metric_name:
                    continue

                range_str = str(row.get("Score Range (<50 / 50-85 / 85-100)"))
                min_s, max_s = 0, 100
                if "<" in range_str:
                    max_s = 49
                elif "-" in range_str:
                    parts = range_str.split("-")
                    min_s, max_s = safe_int(parts[0].strip(), 0), safe_int(parts[1].strip(), 100)
                elif "85" in range_str:
                    min_s = 85

                queries.append(f"\n-- Feedback for metric '{metric_name}' (Score {min_s}-{max_s})")
                queries.append(generate_feedback_query(
                    f"(SELECT id FROM simulator WHERE title = {escape_sql_string(sim_data['title'])})",
                    metric_name,
                    min_s, max_s,
                    strength=clean_content(row.get("Strength Text")),
                    risk=clean_content(row.get("Risk Text")),
                    micro_practice=clean_content(row.get("Suggested Micro-Practice")),
                    recommended_module_id=None,
                    recommendation_reason=clean_content(row.get("Recommendation Reason"))
                ))

    # Save to file if output_file is specified
    if output_file:
        save_queries_to_file(output_file, queries)

    return queries
