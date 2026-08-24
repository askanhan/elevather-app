# Import execute_command method from /src/database/connection.py
# Import datetime for created_at field in database
from .connection import execute_command
from datetime import datetime


# Function to get a category ID by its title, or create it if it doesn't exist - data abstraction
# - title: name of the category -> "I Dare"
# - description: description of the category
# Returns: id of the category
def get_or_create_module_category(title, description="Default description"):
    # 1. Search if the category already exists
    sql_search = "SELECT id FROM module_category WHERE title = %s"
    result = execute_command(sql_search, (title,))

    if result:
        # If found, return the ID
        return result[0]['id']
    else:
        # If not found, create it
        print(f"Category '{title}' not found. Creating it...")
        sql_insert = "INSERT INTO module_category (title, description, created_at) VALUES (%s, %s, %s)"
        return execute_command(sql_insert, (title, description, datetime.now()), is_insert=True)


# Function to create a module
# - category_id: id of the category for the module
# - day: day of the module
# - title: title of the module
# - description: description of the module
# - target_audience: who the module is for
# - estimated_duration: time in minutes the module takes to be completed
# Returns: id of the created module
def create_module(category_id, day, title, description, target_audience=None, estimated_duration=None):
    sql = "INSERT INTO module(module_category_id, day_number, title, description, target_audience, estimated_duration, created_at)VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (category_id, day, title, description, target_audience, estimated_duration, datetime.now())
    module_id = execute_command(sql, values, is_insert=True)
    print(f"Module '{title}' created with ID: {module_id}")
    return module_id

# Function to create a simulator - data encapsulation
# - title: name of the simulator
# - description: summary of the simulation goals
# - level: one between 'intro', 'core', 'advanced'
# - localisation: the setting -> 'Work', 'Home'
# - duration: estimated time the simulator is going to take in minutes
# Returns: id of the newly created simulator
def create_simulator(title, description, level, localisation, duration):
    sql = "INSERT INTO simulator(title, description, level, localisation, estimated_duration, created_at)VALUES (%s, %s, %s, %s, %s, %s)"
    values = (title, description, level, localisation, duration, datetime.now())
    simulator_id = execute_command(sql, values, is_insert=True)
    if simulator_id:
        print(f"Simulator '{title}' created with ID: {simulator_id}")
    return simulator_id

# Function to create a full card in card table
# - owner_type: type of the parent entity (module or simulator)
# - owner_id: id of the parent entity
# - order: position of the card in the parent
# - title: main title of the card
# - subtitle: subtitle of the card
# - end_text: end text for simulator card (added in the word)
# - why_this_question: reason of the question in simulator
# Returns: id of the card just created
def create_full_card(owner_type, owner_id, order, title=None, subtitle=None, end_text=None, why_this_question=None):
    sql = "INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (owner_type, owner_id, order, title, subtitle, end_text, why_this_question)
    return execute_command(sql, values, is_insert=True)

# Function to create a component (except MCQ component) and link it to the card
# - card_id: ID of the parent card
# - table_name: database table name of the component
# - comp_type: type of the component (text, image, etc.)
# - order: position of the component in the card
# - **fields: dictionary of columns (image_alt, author, etc.)
# Returns: id of the created component
def add_simple_component(card_id, table_name, comp_type, order, **fields):
    columns = ", ".join(fields.keys())
    placeholders = ", ".join(["%s"] * len(fields))
    sql_command = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
    values = tuple(fields.values())
    component_id = execute_command(sql_command, values, is_insert=True)
    if component_id:
        link_component_to_card(card_id, comp_type, order, component_id)
    return component_id

# Function to create an MCQ component and link it to the card
# - card_id: id of the parent card
# - order: position of the component in the card
# - question_text: text of the question
# - options_list: list of options (can be any length, from simple strings or dicts)
# Returns: id of the created MCQ component
def add_mcq_component(card_id, order, question_text, options_list):
    sql_command = "INSERT INTO component_mcq (question) VALUES (%s)"
    values = (question_text, )
    mcq_id = execute_command(sql_command, values, is_insert=True)

    if mcq_id:
        link_component_to_card(card_id, 'mcq', order, mcq_id)

        # Dynamically handle all options regardless of count
        for option in options_list:
            # Case A: Simple string option (used in course modules)
            if isinstance(option, str):
                sql_opt = "INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES (%s, %s)"
                values_opt = (mcq_id, option)
                execute_command(sql_opt, values_opt, is_insert=True)

            # Case B: Dictionary option (used in simulators with feedback and weights)
            elif isinstance(option, dict):
                sql_opt = "INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES (%s, %s, %s)"
                values_opt = (mcq_id, option.get('text'), option.get('feedback'))
                option_id = execute_command(sql_opt, values_opt, is_insert=True)

                # Link weights to metrics if present
                if option_id and option.get('weights'):
                    for metric_name, weight in option['weights'].items():
                        res = execute_command("SELECT id FROM simulator_metric WHERE name = %s", (metric_name,))
                        if res:
                            metric_id = res[0]['id']
                            sql_weight = "INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES (%s, %s, %s)"
                            values_weight = (option_id, metric_id, weight)
                            execute_command(sql_weight, values_weight, is_insert=True)
    return mcq_id

# Function to link a component to a card in card_contains table
# - card_id: id of the card
# - comp_type: type of component
# - order: position of the component in the card
# - comp_id: id of the component
def link_component_to_card(card_id, comp_type, order, comp_id):
    sql_command = "INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES (%s, %s, %s, %s)"
    values = (card_id, comp_type, order, comp_id)
    execute_command(sql_command, values, is_insert=True)
    print(f"Linked {comp_type} (ID:{comp_id}) to Card {card_id}")

# Function to create list component items and link them to the card
# - card_id: id of the parent card
# - order: starting position of the components in the card
# - intro_text: introduction/title text for the list (inserted as first item)
# - list_items: list of list item strings (each becomes a separate row in component_list)
# Returns: list of created component IDs for all list items
def add_list_component(card_id, order, intro_text, list_items=None):
    """
    Create multiple list component items as individual rows in component_list.
    Each item (intro_text + all list_items) is inserted as a separate row.
    All items are linked to the same card with sequential order indices.

    Returns: List of component IDs created
    """
    print(f"\n   DEBUG add_list_component called:")
    print(f"      card_id={card_id}, order={order}")
    print(f"      intro_text='{intro_text}'")
    print(f"      list_items={list_items}")

    created_ids = []
    current_order = order

    # Insert intro_text as first list item if provided
    if intro_text:
        print(f"\n   Inserting intro/title...")
        sql_command = "INSERT INTO component_list (content) VALUES (%s)"
        values = (intro_text,)
        list_item_id = execute_command(sql_command, values, is_insert=True)
        if list_item_id:
            print(f"      Inserted, ID: {list_item_id}, order: {current_order}")
            link_component_to_card(card_id, 'list', current_order, list_item_id)
            created_ids.append(list_item_id)
            current_order += 1
        else:
            print(f"      Failed to insert intro")

    # Insert each list item as a separate row in component_list
    if list_items:
        print(f"\n   Inserting {len(list_items)} list items...")
        for item_idx, item in enumerate(list_items):
            if item:  # Only insert non-empty items
                print(f"      Item {item_idx + 1}: '{item[:40]}...'")
                sql_command = "INSERT INTO component_list (content) VALUES (%s)"
                values = (item,)
                list_item_id = execute_command(sql_command, values, is_insert=True)
                if list_item_id:
                    print(f"         Inserted, ID: {list_item_id}, order: {current_order}")
                    link_component_to_card(card_id, 'list', current_order, list_item_id)
                    created_ids.append(list_item_id)
                    current_order += 1
                else:
                    print(f"         Failed to insert item")

    print(f"\n   add_list_component result: {len(created_ids)} rows created")
    return created_ids

# Function to link a module to its tags
# - module_id: id of the module
# - tag_title: title of the tag
# Returns:
# - If success: id of the created link
# - If error: None
def link_module_to_tag(module_id, tag_title):
    # Search if exists
    res = execute_command("SELECT id FROM module_tag WHERE title = %s", (tag_title,))
    if res:
        tag_id = res[0]['id']
    #if not then create
    else:
        tag_id = execute_command("INSERT INTO module_tag (title, created_at) VALUES (%s, %s)",
                                 (tag_title, datetime.now()), is_insert=True)

    #link
    if tag_id:
        return execute_command("INSERT INTO module_contains_tags (module_id, module_tag_id) VALUES (%s, %s)",
                               (module_id, tag_id), is_insert=True)

#function to link a simulator to its metrics
# - simulator_id: id of the simulator
# - metric_name: name of the metric
# return:
# - if success : id of the created link
# - if error : None
def link_simulator_to_metric(simulator_id, metric_name):
    #search if the metric name already exists
    sql_command = "SELECT id FROM simulator_metric WHERE name = %s"
    result = execute_command(sql_command, (metric_name,))

    if result:
        #if it exists, execute_command returns a list of dictionaries (because of dictionary=True)
        metric_id = result[0]['id']
    # if not then create
    else:
        sql_insert_metric_commmand = "INSERT INTO simulator_metric (name) VALUES (%s)"
        metric_id = execute_command(sql_insert_metric_commmand, (metric_name,), is_insert=True)

    #link the simulator and the metric in the junction table
    if metric_id:
        sql_link = "INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES (%s, %s)"
        return execute_command(sql_link, (simulator_id, metric_id), is_insert=True)
    return None

#function to add feedback
# - simulator_id: id of the simulator
# - metric_id: id of the metric
# - min_s: minimum score range
# - max_s: maximum score range
# - strength: strength feedback message
# - risk: risk feedback message
# - micro_practice: suggested micro practice text
# - recommended_module_id: id of recommended module
# - recommendation_reason: explanation for recommendation
# return:
# - if success: id of the created feedback tier
# - if error: None
def add_simulator_feedback(simulator_id, metric_id, min_s, max_s, strength, risk, micro_practice, recommended_module_id, recommendation_reason):
    sql_command = "INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    values = (simulator_id, metric_id, min_s, max_s, strength, risk, micro_practice, recommended_module_id, recommendation_reason)
    return execute_command(sql_command, values, is_insert=True)

#function to link a simulator to its tags
# - simulator_id: id of the simulator
# - tag_name: name of the tag
# return:
# - if success : id of the created link
# - if error : None
def link_simulator_to_tag(simulator_id, tag_name):
    #search if exists
    res = execute_command("SELECT id FROM simulator_tag WHERE name = %s", (tag_name,))
    if res:
        tag_id = res[0]['id']
    #if not then create
    else:
        tag_id = execute_command("INSERT INTO simulator_tag (name) VALUES (%s)", (tag_name,), is_insert=True)

    #link
    if tag_id:
        return execute_command("INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES (%s, %s)",
                               (simulator_id, tag_id), is_insert=True)

#function to clear only content data (courses/simulators) while preserving user data
def clear_content_only_data():
    """
    Clear only content-related data (courses, simulators, cards, components)
    while PRESERVING all user-related data (users, progress, responses, scores, etc.)

    This is useful for refreshing course/simulator content without losing user progress.
    """
    print("\n" + "="*60)
    print("🗑️  CLEARING CONTENT DATA ONLY (Preserving User Data)...")
    print("="*60)

    try:
        # Disable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=0", is_insert=False)

        # List of CONTENT ONLY tables to clear (NO user data)
        content_tables_to_clear = [
            # MCQ related tables (depends on cards)
            'multiple_choices_options_weights',
            'multiple_choices_options',

            # Card and component relationships
            'card_contains',

            # Components tables
            'component_title',
            'component_subtitle',
            'component_text',
            'component_quote',
            'component_image',
            'component_video',
            'component_mcq',
            'component_open_questions',
            'component_list',
            'component_last_messages',

            # Cards
            'card',

            # Module relationships and tags
            'module_contains_tags',
            'module_tag',

            # Simulator relationships and tags (NOT simulator_feedback_tiers - those are user responses)
            'simulator_contains_metric',
            'simulator_contains_tag',
            'simulator_metric',
            'simulator_tag',

            # Main content entities
            'simulator',
            'module',
            'module_category'
        ]

        cleared_count = 0
        skipped_count = 0
        for table in content_tables_to_clear:
            try:
                # Check if table exists before trying to clear it
                check_table = execute_command(f"SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='{table}' AND TABLE_SCHEMA=DATABASE()", is_insert=False)
                if check_table:
                    result = execute_command(f"DELETE FROM {table}", is_insert=False)
                    print(f"✅ Cleared table: {table}")
                    cleared_count += 1
                else:
                    print(f"⏭️  Skipped table (not found): {table}")
                    skipped_count += 1
            except Exception as e:
                print(f"⚠️  Could not clear table {table}: {str(e)}")
                continue

        # Re-enable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)

        print(f"\n✅ Successfully cleared {cleared_count} content tables!")
        print(f"⚠️  Preserved all user-related data ({skipped_count} tables not found)")
        print("="*60 + "\n")

    except Exception as e:
        print(f"❌ Error clearing content data: {str(e)}")
        # Make sure to re-enable foreign key checks even if there's an error
        try:
            execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)
        except:
            pass
        raise


#function to clear all data from all tables (respecting foreign key constraints)
def clear_all_database_data():
    """
    Clear all data from the database while preserving table structures.
    Disables foreign key checks temporarily to handle the deletion order.
    Only clears tables that actually exist in the database.
    """
    print("\n" + "="*60)
    print("🗑️  CLEARING ALL DATABASE DATA...")
    print("="*60)

    try:
        # Disable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=0", is_insert=False)

        # List of ALL tables to potentially clear (order doesn't matter with FK checks disabled)
        tables_to_clear = [
            #user-related tables
            'user_daily_checkin_response',
            'user_daily_power_check',
            'user_response_open_questions',
            'user_response_mcq',
            'user_score_simulator',
            'user_progress',
            'story_contains_tag',
            'user_story_reaction',
            'user_story',

            #mcq related tables
            'multiple_choices_options_weights',
            'multiple_choices_options',

            #card and component relationships
            'card_contains',

            #components tables
            'component_title',
            'component_subtitle',
            'component_text',
            'component_quote',
            'component_image',
            'component_video',
            'component_mcq',
            'component_open_questions',
            'component_list',
            'component_last_messages',

            #cards
            'card',

            #module relationships and tags
            'module_contains_tags',
            'module_tag',

            #simulator relationships and tags
            'simulator_contains_metric',
            'simulator_contains_tag',
            'simulator_feedback_tiers',
            'simulator_metric',
            'simulator_tag',

            #daily check-in
            'daily_checkin_option',
            'daily_checkin_question',
            'daily_checkin_metric',

            #user story tags
            'user_story_tag',

            #main entities
            'simulator',
            'module',
            'module_category'
        ]

        cleared_count = 0
        skipped_count = 0
        for table in tables_to_clear:
            try:
                #check if table exists before trying to clear it
                check_table = execute_command(f"SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='{table}' AND TABLE_SCHEMA=DATABASE()", is_insert=False)
                if check_table:
                    result = execute_command(f"DELETE FROM {table}", is_insert=False)
                    print(f"✅ Cleared table: {table}")
                    cleared_count += 1
                else:
                    print(f"⏭️  Skipped table (not found): {table}")
                    skipped_count += 1
            except Exception as e:
                print(f"⚠️  Could not clear table {table}: {str(e)}")
                continue

        #re-enable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)

        print(f"\n✅ Successfully cleared {cleared_count} tables! ({skipped_count} tables not found)")
        print("="*60 + "\n")

    except Exception as e:
        print(f"❌ Error clearing database: {str(e)}")
        #make sure to re-enable foreign key checks even if there's an error
        try:
            execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)
        except:
            pass
        raise


#function to reset AUTO_INCREMENT for content tables only (preserving user data sequences)
def reset_content_only_auto_increment():
    """
    Reset AUTO_INCREMENT to 1 for content-related tables only.
    Preserves AUTO_INCREMENT values for user-related tables.
    """
    print("\n" + "="*60)
    print("🔄 RESETTING AUTO_INCREMENT FOR CONTENT TABLES ONLY...")
    print("="*60)

    try:
        # Disable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=0", is_insert=False)

        # List of CONTENT tables with AUTO_INCREMENT to reset
        content_tables_to_reset = [
            'module_category',
            'module_tag',
            'module',
            'module_contains_tags',
            'card',
            'card_contains',
            'component_title',
            'component_subtitle',
            'component_text',
            'component_quote',
            'component_image',
            'component_video',
            'component_mcq',
            'component_open_questions',
            'component_list',
            'component_last_messages',
            'multiple_choices_options',
            'multiple_choices_options_weights',
            'simulator',
            'simulator_tag',
            'simulator_contains_tag',
            'simulator_metric',
            'simulator_contains_metric'
        ]

        reset_count = 0
        for table in content_tables_to_reset:
            try:
                # Check if table exists
                check_table = execute_command(f"SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='{table}' AND TABLE_SCHEMA=DATABASE()", is_insert=False)
                if check_table:
                    # Reset AUTO_INCREMENT to 1
                    execute_command(f"ALTER TABLE {table} AUTO_INCREMENT=1", is_insert=False)
                    print(f"✅ Reset AUTO_INCREMENT: {table}")
                    reset_count += 1
                else:
                    print(f"⏭️  Skipped table (not found): {table}")
            except Exception as e:
                print(f"⚠️  Could not reset AUTO_INCREMENT for {table}: {str(e)}")
                continue

        # Re-enable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)

        print(f"\n✅ Successfully reset AUTO_INCREMENT for {reset_count} content tables!")
        print("="*60 + "\n")

    except Exception as e:
        print(f"❌ Error resetting AUTO_INCREMENT: {str(e)}")
        # Make sure to re-enable foreign key checks even if there's an error
        try:
            execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)
        except:
            pass
        raise


#function to reset AUTO_INCREMENT for all tables
def reset_all_auto_increment():
    """
    Reset AUTO_INCREMENT to 1 for all tables.
    This ensures IDs start from 1 every time the script runs.
    """
    print("\n" + "="*60)
    print("🔄 RESETTING AUTO_INCREMENT FOR ALL TABLES...")
    print("="*60)

    try:
        #disable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=0", is_insert=False)

        #list of ALL tables with AUTO_INCREMENT
        tables_to_reset = [
            'module_category',
            'module_tag',
            'module',
            'module_contains_tags',
            'card',
            'card_contains',
            'component_title',
            'component_subtitle',
            'component_text',
            'component_quote',
            'component_image',
            'component_video',
            'component_mcq',
            'component_open_questions',
            'component_list',
            'component_last_messages',
            'multiple_choices_options',
            'multiple_choices_options_weights',
            'simulator',
            'simulator_tag',
            'simulator_contains_tag',
            'simulator_metric',
            'simulator_contains_metric',
            'simulator_feedback_tiers',
            'user_score_simulator',
            'user_response_mcq',
            'user_response_open_questions',
            'user_progress',
            'daily_checkin_metric',
            'daily_checkin_question',
            'daily_checkin_option',
            'user_daily_power_check',
            'user_daily_checkin_response',
            'user_story',
            'user_story_reaction',
            'user_story_tag',
            'story_contains_tag'
        ]

        reset_count = 0
        for table in tables_to_reset:
            try:
                #check if table exists
                check_table = execute_command(f"SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='{table}' AND TABLE_SCHEMA=DATABASE()", is_insert=False)
                if check_table:
                    #reset AUTO_INCREMENT to 1
                    execute_command(f"ALTER TABLE {table} AUTO_INCREMENT=1", is_insert=False)
                    print(f"✅ Reset AUTO_INCREMENT: {table}")
                    reset_count += 1
                else:
                    print(f"⏭️  Skipped table (not found): {table}")
            except Exception as e:
                print(f"⚠️  Could not reset AUTO_INCREMENT for {table}: {str(e)}")
                continue

        #re-enable foreign key checks
        execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)

        print(f"\n✅ Successfully reset AUTO_INCREMENT for {reset_count} tables!")
        print("="*60 + "\n")

    except Exception as e:
        print(f"❌ Error resetting AUTO_INCREMENT: {str(e)}")
        # Make sure to re-enable foreign key checks even if there's an error
        try:
            execute_command("SET FOREIGN_KEY_CHECKS=1", is_insert=False)
        except:
            pass
        raise


