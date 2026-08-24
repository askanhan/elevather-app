import os
from .excel_mapping import FOLDER_MAP


def discover_excel_files(data_type):
    """
    Automatically discover all Excel files in the data-sources folder and subfolders.
    For courses, searches in: courses/, courses/BE/, courses/CZ/, courses/DE/, courses/GR/, courses/PL/
    For simulators, searches in: simulators/

    - data_type (str): 'course' or 'simulator'
    - Returns: list of tuples (relative_path, filename) for each .xlsx file found
    """
    if data_type not in FOLDER_MAP:
        print(f"ERROR: Unknown data type: {data_type}")
        return []

    current_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(current_dir, "../../"))
    folder_name = FOLDER_MAP[data_type]
    folder_path = os.path.join(project_root, 'data-sources', folder_name)

    if not os.path.exists(folder_path):
        print(f"WARNING: Folder not found: {folder_path}")
        return []

    # Recursively find all .xlsx files
    excel_files = []
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.xlsx') and not file.startswith('~'):
                # Get relative path from the base folder
                relative_path = os.path.relpath(os.path.join(root, file), folder_path)
                excel_files.append({
                    'filename': file,
                    'relative_path': relative_path,
                    'full_path': os.path.join(root, file)
                })

    if not excel_files:
        print(f"WARNING: No Excel files found in: {folder_path}")
        return []

    print(f"Found {len(excel_files)} {data_type} file(s):")
    for file_info in excel_files:
        print(f"   - {file_info['relative_path']}")

    return excel_files


def get_data_source_path(data_type, filename):
    """
    Get the full path to a data source file:
    - data_type (str): 'course' or 'simulator'
    - filename (str): Name of the Excel file (e.g., 'course1.xlsx')
    """
    if data_type not in FOLDER_MAP:
        raise ValueError(f"Unknown data type: {data_type}")

    current_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(current_dir, "../../"))
    folder_name = FOLDER_MAP[data_type]
    return os.path.join(project_root, 'data-sources', folder_name, filename)




