from importlib.metadata import version
from platformdirs import user_data_dir, user_config_dir, user_documents_dir
from pathlib import Path
from colorama import just_fix_windows_console

__version__ = "1.0.0"

# Allow colorama to work on Windows consoles
just_fix_windows_console()
