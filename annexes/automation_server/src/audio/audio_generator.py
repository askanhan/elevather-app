"""
Audio Generation Module
Responsible for triggering audio file generation via Django management command
"""
import os
import subprocess


def generate_audio_files(keep_old=False, voice=None, speed=None):
    """
    Trigger the audio generation process by calling the Django management command via subprocess.

    Note: This function assumes that the backend Django project is properly set up with the
    generate_audios command and that BACKEND_PATH is configured in .env

    Args:
        keep_old (bool): Whether to keep old audio files
        voice (str, optional): Voice to use for audio generation (default: af_heart)
        speed (float, optional): Speed of audio generation (default: 0.9)

    Returns:
        bool: True if audio generation succeeded, False otherwise
    """
    print("\n" + "="*60)
    print("GENERATING AUDIO FILES...")
    print("="*60)

    # Get backend path from .env
    backend_dir = os.getenv('BACKEND_PATH')

    if not backend_dir:
        print("WARNING: BACKEND_PATH not configured in .env file!")
        print("   Please create a .env file with BACKEND_PATH variable")
        return False

    # Normalize path to avoid issues with trailing slashes or backslashes
    backend_dir = os.path.normpath(backend_dir)

    # Verify that backend directory exists
    if not os.path.exists(backend_dir):
        print(f"WARNING: Backend directory not found: {backend_dir}")
        print("   Skipping audio generation...")
        return False

    # Verify that manage.py exists in the backend directory
    manage_py = os.path.join(backend_dir, 'manage.py')
    if not os.path.exists(manage_py):
        print(f"WARNING: manage.py not found in: {backend_dir}")
        print("   Skipping audio generation...")
        return False

    # Construct path to python executable in the venv
    python_exe = os.path.join(backend_dir, 'venv_elevate', 'Scripts', 'python.exe')

    # Verify that python executable exists (handle both Windows and Unix-like paths)
    if not os.path.exists(python_exe):
        python_exe = os.path.join(backend_dir, 'venv_elevate', 'bin', 'python')

    if not os.path.exists(python_exe):
        print(f"WARNING: Python venv executable not found!")
        print(f"   Expected: {os.path.join(backend_dir, 'venv_elevate', 'Scripts', 'python.exe')}")
        print("   Skipping audio generation...")
        return False

    # Construct the command
    command = [python_exe, 'manage.py', 'generate_audios']

    # Add options based on parameters
    if keep_old:
        command.append('--keep-old')

    # Read default voice and speed from environment variables, with fallback to defaults if not set
    default_voice = os.getenv('AUDIO_VOICE', 'af_heart')
    default_speed = float(os.getenv('AUDIO_SPEED', '0.9'))

    voice = voice or default_voice
    if voice != 'af_heart':
        command.extend(['--voice', voice])

    speed = speed or default_speed
    if speed != 0.9:
        command.extend(['--speed', str(speed)])

    try:
        # Print the command and working directory for transparency
        print(f"Executing: {' '.join(command)}")
        print(f"Working directory: {backend_dir}\n")

        # Execute the command and capture output
        result = subprocess.run(
            command,
            cwd=backend_dir,
            capture_output=True,
            text=True,
            timeout=3600  # 1 hour max
        )

        if result.stdout:
            print("Audio generation output:")
            print(result.stdout)

        if result.returncode == 0:
            print("\nAudio generation completed successfully!")
            return True
        else:
            print(f"\nAudio generation failed with exit code {result.returncode}")
            if result.stderr:
                print("Error output:")
                print(result.stderr)
            return False

    except subprocess.TimeoutExpired:
        print("Audio generation timed out (> 1 hour)")
        return False
    except Exception as e:
        print(f"Failed to trigger audio generation: {str(e)}")
        return False
    finally:
        print("="*60 + "\n")

