import os
import sys

# Load environment variables from .env file
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    print("WARNING: python-dotenv not installed. Install with: pip install python-dotenv")

# Import modules
from src.database.connection import connect_to_database
from src.database.repository import (
    clear_all_database_data, reset_all_auto_increment,
    clear_content_only_data, reset_content_only_auto_increment,
    seed_module_categories
)
from src.database.importer import import_all_courses, import_all_simulators
from src.utils.file_discovery import discover_excel_files
from src.utils.sql_generator import generate_sql_course, generate_sql_simulator
from src.audio.audio_generator import generate_audio_files


def generate_sql_for_all_files():
    """
    Discover and generate SQL queries for all Excel files.

    Returns:
        tuple: (total_course_queries, total_simulator_queries)
    """
    print("\n" + "="*60)
    print("DISCOVERING AND GENERATING SQL QUERIES...")
    print("="*60)

    # Discover files
    course_files = discover_excel_files("course")
    simulator_files = discover_excel_files("simulator")

    # Create SQL output directory if it doesn't exist
    sql_output_dir = "generated_sql"
    if not os.path.exists(sql_output_dir):
        os.makedirs(sql_output_dir)

    all_course_queries = []
    all_simulator_queries = []

    # Generate SQL for all course files
    for file_info in course_files:
        # Generate safe filename for output (replace path separators and spaces)
        if isinstance(file_info, dict):
            safe_filename = file_info['relative_path'].replace('\\', '_').replace('/', '_').replace(' ', '_')
            base_name = os.path.splitext(safe_filename)[0]
        else:
            base_name = os.path.splitext(file_info)[0]

        output_path = os.path.join(sql_output_dir, f"{base_name}_queries.sql")
        queries = generate_sql_course(file_info, output_file=output_path)
        all_course_queries.extend(queries)

    # Generate SQL for all simulator files
    for file_info in simulator_files:
        # Generate safe filename for output
        if isinstance(file_info, dict):
            safe_filename = file_info['relative_path'].replace('\\', '_').replace('/', '_').replace(' ', '_')
            base_name = os.path.splitext(safe_filename)[0]
        else:
            base_name = os.path.splitext(file_info)[0]

        output_path = os.path.join(sql_output_dir, f"{base_name}_queries.sql")
        queries = generate_sql_simulator(file_info, output_file=output_path)
        all_simulator_queries.extend(queries)

    print(f"\nGenerated {len(all_course_queries)} total queries for {len(course_files)} course(s)")
    print(f"Generated {len(all_simulator_queries)} total queries for {len(simulator_files)} simulator(s)")

    return len(all_course_queries), len(all_simulator_queries)


def run_database_import(preserve_user_data=True):
    """
    Clear database and import all Excel files.

    Args:
        preserve_user_data (bool): If True, only clears content (courses/simulators).
                                   If False, clears everything including user data.

    Returns:
        bool: True if import was successful
    """
    print("\n" + "="*60)
    print("STARTING DATABASE IMPORT...")
    print("="*60)

    # Connect to database
    conn = connect_to_database()
    if not conn:
        print("ERROR: Failed to connect to database")
        return False

    try:
        # Clear data based on mode
        if preserve_user_data:
            print("\nMODE: Preserving user data")
            clear_content_only_data()
            reset_content_only_auto_increment()
        else:
            print("\nMODE: Clearing ALL data (including user data)")
            clear_all_database_data()
            reset_all_auto_increment()

        # Seed the fixed module categories before any course references them,
        # so their ids are deterministic (1-7) regardless of import order
        print("\n" + "="*60)
        print("SEEDING MODULE CATEGORIES...")
        print("="*60)
        seed_module_categories()

        # Import courses
        print("\n" + "="*60)
        print("IMPORTING COURSES...")
        print("="*60)
        courses_imported = import_all_courses()

        # Import simulators
        print("\n" + "="*60)
        print("IMPORTING SIMULATORS...")
        print("="*60)
        simulators_imported = import_all_simulators()

        print("\n" + "="*60)
        print("Database import completed successfully!")
        print(f"   Courses imported: {courses_imported}")
        print(f"   Simulators imported: {simulators_imported}")
        print("="*60)

        return True

    finally:
        conn.close()
        print("\n--- Connection closed ---")


def main():
    """
    Main entry point - Orchestrates the entire process.

    Command line arguments:
    - --generate-only, -g: Generate SQL queries only (no execution)
    - --run-only, -r: Run import only (no SQL generation)
    - --full-clear: Clear ALL data including user data (default: preserve user data)
    - --preserve-user-data: Preserve user data when clearing (default behavior)
    """
    # Parse command line arguments
    generate_only = "--generate-only" in sys.argv or "-g" in sys.argv
    run_only = "--run-only" in sys.argv or "-r" in sys.argv
    full_clear = "--full-clear" in sys.argv
    preserve_user_data = not full_clear  # Default is to preserve user data

    # Display mode
    if generate_only:
        print("\nMODE: Generating SQL queries only (no execution)")
    elif run_only:
        print("\nMODE: Running import only (no SQL generation)")
    else:
        print("\nMODE: Generating SQL queries AND running import")

    if preserve_user_data and not generate_only:
        print("DATA MODE: Preserving user data (content refresh)")
    elif not generate_only:
        print("DATA MODE: Full database clear (all data will be deleted)")

    try:
        # Generate SQL queries from all discovered files
        if not run_only:
            generate_sql_for_all_files()

        # Run import if not in generate_only mode
        if not generate_only:
            success = run_database_import(preserve_user_data=preserve_user_data)

            if success:
                # Trigger audio generation after database is successfully populated
                generate_audio_files()

    except KeyboardInterrupt:
        print("\n\nProcess interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n\nUnexpected error: {str(e)}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

    # Final message
    if generate_only:
        print("\nSQL generation completed. Check the 'generated_sql' folder.")
    else:
        print("\nProcess completed successfully!")


if __name__ == "__main__":
    main()



