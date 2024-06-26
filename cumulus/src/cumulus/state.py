import os
from dataclasses import dataclass
from pathlib import Path

from platformdirs import user_pictures_dir


def get_xdg_path(environment_name: str, fallback_path_name: str) -> Path:
    try:
        return Path(os.environ[f"XDG_{environment_name}_HOME"]) / "cumulus"
    except KeyError:
        return Path.home() / f".{fallback_path_name}/cumulus"


@dataclass
class State:
    config_path = get_xdg_path("CONFIG", "config")
    wallpaper_path = Path(user_pictures_dir()) / "wallpapers"
