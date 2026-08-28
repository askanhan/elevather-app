from .connection import execute_command
from .repository import (
    get_or_create_module_category, create_module, link_module_to_tag,
    create_full_card, add_simple_component, add_mcq_component,
    add_list_component, create_simulator, link_simulator_to_tag,
    link_simulator_to_metric, add_simulator_feedback
)
from ..utils.excel_loader import (
    load_data, map_excel_to_db, clean_content, extract_full_card_data,
    extract_simulator_cards, parse_comma_list, safe_int
)
from ..utils.excel_mapping import (
    MODULE_TABLE_MAP, SIMULATOR_TABLE_MAP, DAY_NUMBER_OVERRIDES, TITLE_OVERRIDES, CATEGORY_OVERRIDES
)
from ..utils.sql_generator import find_overview_sheet, find_overview_row


def import_course(file_info):
    """
    Import a single course Excel file into the database:
    - file_info (dict): Dictionary with 'filename', 'relative_path', and 'full_path' keys
                        OR just a string for backward compatibility
    """
    # Handle backward compatibility - if string is passed, treat as old style
    if isinstance(file_info, str):
        filename = file_info
        full_path = None
    else:
        filename = file_info.get('filename', '')
        full_path = file_info.get('full_path')

    # 1. load excel file
    course_df = load_data(full_path=full_path) if full_path else load_data("course", filename)
    if not course_df:
        print(f"ERROR: Skipping {filename}")
        return False

    # 2. overview sheet - find it dynamically
    try:
        overview_sheet_name, overview_df = find_overview_sheet(course_df, sheet_type="course")
        overview_row = find_overview_row(overview_df, sheet_type="course")
    except ValueError as e:
        print(f"ERROR: {str(e)}")
        return False

    module_data = map_excel_to_db(overview_row, MODULE_TABLE_MAP)
    module_data['title'] = TITLE_OVERRIDES.get(filename, module_data['title'])

    # Fixed category (module_category is seeded in CATEGORY_OVERRIDES order before
    # import, so its id matches the override value directly - no DB lookup needed)
    category_id = CATEGORY_OVERRIDES.get(module_data['title'])
    if category_id is None:
        # Fallback for a course not in the fixed mapping: fall back to raw Excel category
        category_name = clean_content(overview_row.get("Category"))
        if not category_name:
            category_name = "General"
            print(f"WARNING: Category is empty. Using default category: 'General'")
        category_id = safe_int(
            get_or_create_module_category(
                category_name,
                "test description"
            )
        )

    # Create a module into db
    day_number = DAY_NUMBER_OVERRIDES.get(module_data['title'], safe_int(module_data['day_number']))
    module_id = create_module(
        category_id,
        day_number,
        module_data['title'],
        module_data['description'],
        module_data.get('target_audience'),
        safe_int(module_data.get('estimated_duration'))
    )

    if not module_id:
        print(f"ERROR: Failed to create module for {filename}")
        return False

    # Links the tags to its module
    tags = parse_comma_list(overview_row.get("Tags (comma separated)"))
    for tag in tags:
        link_module_to_tag(module_id, tag)

    # 3. cards
    card_count = 1
    for sheet_name, df_sheet in course_df.items():
        if "Card" in sheet_name:
            # Extract card info
            card_attr, components = extract_full_card_data(df_sheet, card_count)

            # Create card into db
            card_id = create_full_card(
                'module', module_id, card_count,
                card_attr['title'], card_attr['subtitle'],
                card_attr['end_text'], card_attr['why_this_question']
            )

            component_order = 1
            # Create component for card into db
            for comp in components:
                if comp['content'] is None and comp['table'] != 'component_list':
                    continue
                if comp['table'] == 'component_mcq':
                    # MCQ with dynamic options
                    add_mcq_component(card_id, component_order, comp['content'], comp.get('options', []))
                    component_order += 1
                elif comp['table'] == 'component_list':
                    # LIST component with dynamic items - creates multiple rows
                    list_items = comp.get('list_items', [])
                    created_ids = add_list_component(card_id, component_order, comp['content'], list_items)
                    # Increment order by number of items created (intro + items)
                    component_order += len(created_ids)
                else:
                    # Simple components (text, image, video, quote, etc.)
                    all_component_data = {comp['column']: comp['content']}
                    # For bonus fields like author, options, etc
                    if comp.get('fields'):
                        all_component_data.update(comp['fields'])
                    add_simple_component(
                        card_id,
                        comp['table'],
                        comp['type_enum'],
                        component_order,
                        **all_component_data
                    )
                    component_order += 1
            print(f"   Card {card_count} created successfully")
            card_count += 1

    print(f"Course '{module_data['title']}' imported successfully")
    return True


def import_simulator(file_info):
    """
    Import a single simulator Excel file into the database:
    - file_info (dict): Dictionary with 'filename', 'relative_path', and 'full_path' keys
                        OR just a string for backward compatibility
    """
    # Handle backward compatibility - if string is passed, treat as old style
    if isinstance(file_info, str):
        filename = file_info
        full_path = None
    else:
        filename = file_info.get('filename', '')
        full_path = file_info.get('full_path')

    # 1. load excel file
    sim_df = load_data(full_path=full_path) if full_path else load_data("simulator", filename)
    if not sim_df:
        print(f"ERROR: Skipping {filename}")
        return False

    # 2. overview sheet - find it dynamically
    try:
        overview_sheet_name, overview_df = find_overview_sheet(sim_df, sheet_type="simulator")
        overview_row = find_overview_row(overview_df, sheet_type="simulator")
    except ValueError as e:
        print(f"ERROR: {str(e)}")
        return False

    sim_data = map_excel_to_db(overview_row, SIMULATOR_TABLE_MAP)

    # Create a simulator into db
    simulator_id = create_simulator(
        sim_data['title'],
        overview_row.get('Description', 'No description'),
        sim_data.get('level', 'intro').lower(),
        sim_data.get('localisation'),
        safe_int(sim_data['estimated_duration']) if sim_data.get('estimated_duration') else 0
    )

    if not simulator_id:
        print(f"ERROR: Simulator could not be created. Skipping {filename}")
        return False

    tags = parse_comma_list(overview_row.get("Tags (comma separated)"))
    for tag in tags:
        link_simulator_to_tag(simulator_id, tag)

    metrics = parse_comma_list(overview_row.get("Metrics (comma separated)"))
    for metric_name in metrics:
        link_simulator_to_metric(simulator_id, metric_name)

    # 3. cards
    cards_sheet = sim_df.get("Cards")
    if cards_sheet is not None:
        simulator_cards = extract_simulator_cards(cards_sheet)

        for i, card_data in enumerate(simulator_cards):
            card_info = card_data["info"]

            card_id = create_full_card(
                'simulator',
                simulator_id,
                card_info['card_order_index'],
                card_info['title'],
                card_info['subtitle'],
                card_info['end_text'],
                card_info['why_this_question']
            )

            comp_order = 1
            for comp in card_data["components"]:
                if comp['type'] in ['image', 'video', 'text']:
                    all_fields = {comp.get('column', 'content'): comp['content']}
                    if comp.get('fields'):
                        all_fields.update(comp['fields'])

                    add_simple_component(
                        card_id,
                        comp.get('table', 'component_text'),
                        comp['type'],
                        comp_order,
                        **all_fields
                    )

                elif comp['type'] == 'mcq':
                    add_mcq_component(
                        card_id,
                        comp_order,
                        comp['content'],
                        comp['options']
                    )
                comp_order += 1
            print(f"   Card {card_info['card_order_index']} created")

        # 4. feedback
        feedback_sheet = sim_df.get("Metric Writing")
        if feedback_sheet is not None:
            print("   Processing feedback tiers...")
            # Some templates merge the "Metric Name" cell across a metric's 3 score-range
            # rows, so only the first row actually holds the name and the other two read
            # as blank/NaN - forward-fill so every row keeps its metric.
            feedback_sheet = feedback_sheet.copy()
            feedback_sheet["Metric Name"] = feedback_sheet["Metric Name"].ffill()

            for _, row in feedback_sheet.iterrows():
                metric_name = clean_content(row.get("Metric Name"))
                if not metric_name:
                    continue

                # Get id of metric
                res = execute_command("SELECT id FROM simulator_metric WHERE name = %s", (metric_name,))
                if not res:
                    continue
                metric_id = res[0]['id']

                # Normalize en-dash/em-dash to a plain hyphen - some source files use
                # "50–85" (en dash) instead of "50-85", which the checks below don't match.
                range_str = str(row.get("Score Range (<50 / 50-85 / 85-100)")).replace("–", "-").replace("—", "-")
                min_s, max_s = 0, 100
                if "<" in range_str:
                    max_s = 49
                elif "-" in range_str:
                    parts = range_str.split("-")
                    min_s, max_s = safe_int(parts[0].strip(), 0), safe_int(parts[1].strip(), 100)
                elif "85" in range_str:
                    min_s = 85

                add_simulator_feedback(
                    simulator_id, metric_id, min_s, max_s,
                    strength=clean_content(row.get("Strength Text")),
                    risk=clean_content(row.get("Risk Text")),
                    micro_practice=clean_content(row.get("Suggested Micro-Practice")),
                    recommended_module_id=None,
                    recommendation_reason=clean_content(row.get("Recommendation Reason"))
                )

    print(f"Simulator '{sim_data['title']}' imported successfully")
    return True


def import_all_courses(filenames=None):
    """
    Import multiple course files into the database:
    - filenames (list, optional): List of specific filenames to import.
                                  If None, will be auto-discovered.
    """
    if filenames is None:
        from ..utils.file_discovery import discover_excel_files
        filenames = discover_excel_files("course")

    if isinstance(filenames, str):
        filenames = [filenames]

    if not filenames:
        print("WARNING: No course files to import")
        return 0

    success_count = 0
    for file_info in filenames:
        # Handle both dict (from discover_excel_files) and string (legacy)
        if isinstance(file_info, dict):
            display_name = file_info.get('relative_path', file_info.get('filename', 'Unknown'))
        else:
            display_name = file_info

        print(f"\n{'='*60}")
        print(f"IMPORTING COURSE: {display_name}")
        print(f"{'='*60}")

        if import_course(file_info):
            success_count += 1

    return success_count


def import_all_simulators(filenames=None):
    """
    Import multiple simulator files into the database:
    - filenames (list, optional): List of specific filenames to import.
                                  If None, will be auto-discovered.
    """
    if filenames is None:
        from ..utils.file_discovery import discover_excel_files
        filenames = discover_excel_files("simulator")

    if isinstance(filenames, str):
        filenames = [filenames]

    if not filenames:
        print("WARNING: No simulator files to import")
        return 0

    success_count = 0
    for file_info in filenames:
        # Handle both dict (from discover_excel_files) and string (legacy)
        if isinstance(file_info, dict):
            display_name = file_info.get('relative_path', file_info.get('filename', 'Unknown'))
        else:
            display_name = file_info

        print(f"\n{'='*60}")
        print(f"IMPORTING SIMULATOR: {display_name}")
        print(f"{'='*60}")

        if import_simulator(file_info):
            success_count += 1

    return success_count




