from .state import State
from .logging import error, warning
from .apply_theme import apply_theme
from .wallpaper import get_wallpaper, set_wallpaper

from typing_extensions import Annotated
import random
from colorama import Fore, Style
import subprocess
import typer
import sys
from pathlib import Path
import tomllib
import platform

app = typer.Typer(no_args_is_help=True)
state = State()


@app.callback()
def main(
    config: Annotated[Path, typer.Option("-c", "--config")] = None,
    data: Annotated[Path, typer.Option("-d", "--data")] = None,
    wallpaper: Annotated[Path, typer.Option("-w", "--wallpaper")] = None,
):
    """CLI utility for the Nubosa system"""

    if config:
        state.config_path = config.absolute()

    if data:
        state.data_path = data.absolute()

    if wallpaper:
        state.wallpaper_path = wallpaper.absolute()

    state.config_path.mkdir(parents=True, exist_ok=True)
    state.data_path.mkdir(parents=True, exist_ok=True)
    state.wallpaper_path.mkdir(parents=True, exist_ok=True)


theme = typer.Typer()
app.add_typer(theme, name="theme")


@theme.command("list")
def list() -> None:
    """List all the available themes"""
    any_theme_detected = False

    print("Themes:")
    for theme in state.config_path.glob("*"):
        if not theme.is_dir():
            warning(
                f'Themes directory at "{state.config_path}" is polluted with non directory type file "{theme.name}"'
            )
            continue

        with open(theme / "manifest.toml", "rb") as file:
            theme_manifest = tomllib.load(file)
            print(
                f"  - {Fore.CYAN}{theme_manifest["name"]}{Style.RESET_ALL} ({theme.name})"
            )
            any_theme_detected = True

    if not any_theme_detected:
        print(f"  {Fore.BLUE}(No themes detected){Style.RESET_ALL}")


@theme.command("apply")
def apply(theme_name: str) -> None:
    apply_theme(theme_name, state)


wallpaper = typer.Typer()
app.add_typer(wallpaper, name="wallpaper")


@wallpaper.command("get")
def get() -> Path:
    get_wallpaper(state.data_path, state.wallpaper_path)


@wallpaper.command("set")
def set() -> None:
    wallpaper_path = set_wallpaper(state.data_path, state.wallpaper_path)
    print(f'Applied wallpaper {Fore.CYAN}"{wallpaper_path}"{Style.RESET_ALL}')


if __name__ == "__main__":
    app()
