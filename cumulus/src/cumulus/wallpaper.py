from .state import State
from .logging import error
import random
import subprocess
import sys
from pathlib import Path
import platform


def get_wallpaper(
    data_path: Path, wallpaper_path: Path, print_path: bool = True
) -> Path:
    applied_theme_info_path = data_path / "applied-theme.txt"

    if not applied_theme_info_path.is_file():
        error("No theme currently applied")
        sys.exit(1)

    with open(applied_theme_info_path, "r") as file:
        # Remove the new line char
        applied_theme = file.readline()[:-1]
        wallpapers_dir_path = wallpaper_path / applied_theme

        if not wallpapers_dir_path.is_dir():
            error(f'Missing wallpapers path at "{wallpapers_dir_path}"')
            sys.exit(1)

        wallpapers = [
            wallpaper
            for wallpaper in wallpapers_dir_path.rglob("*")
            if wallpaper.is_file()
        ]
        random_wallpaper = random.choice(wallpapers)

        if print_path:
            print(random_wallpaper)
        return random_wallpaper


def set_wallpaper(data_path: Path, wallpaper_path: Path) -> Path:
    random_wallpaper = get_wallpaper(data_path, wallpaper_path, print_path=False)
    system = platform.system()

    if system == "Linux":
        subprocess.run(["swww", "img", random_wallpaper, "-t", "wipe"])

    if system == "Darwin":
        subprocess.run(
            [
                "osascript",
                "-e",
                f'tell application "Finder" to set desktop picture to POSIX file "{random_wallpaper}"',
            ]
        )

    return random_wallpaper
