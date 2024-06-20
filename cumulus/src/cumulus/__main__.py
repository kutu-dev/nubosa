from .state import State
from .logging import error, warning
from .apply_theme import apply_theme

from typing_extensions import Annotated
import random
import typer
import sys
from pathlib import Path
import tomllib
import yaml
from colorama import Fore, Back, Style
from platformdirs import user_documents_dir

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
            warning(f"Themes directory at \"{state.config_path}\" is polluted with non directory type file \"{theme.name}\"")
            continue

        with open(theme / "manifest.toml", "rb") as file:
            theme_manifest = tomllib.load(file)
            print(f"  - {Fore.CYAN}{theme_manifest["name"]}{Style.RESET_ALL} ({theme.name})")
            any_theme_detected = True

    if not any_theme_detected:
        print(f"  {Fore.BLUE}(No themes detected){Style.RESET_ALL}")

@theme.command("apply")
def apply(theme_name: str) -> None:
    apply_theme(theme_name, state)

wallpaper = typer.Typer()
app.add_typer(wallpaper, name="wallpaper")

@wallpaper.command("get")
def get() -> None:
    applied_theme_info_path = state.data_path / "applied-theme.txt"

    if not applied_theme_info_path.is_file():
        error("No theme currently applied")
        sys.exit(1)

    with open(applied_theme_info_path, "r") as file:
        # Remove the new line char
        applied_theme = file.readline()[:-1]
        wallpapers_dir_path = state.wallpaper_path / applied_theme

        if not wallpapers_dir_path.is_dir():
            error(f"Missing wallpapers path at \"{wallpapers_dir_path}\"")
            sys.exit(1)

        wallpapers = [wallpaper for wallpaper in wallpapers_dir_path.rglob("*") if wallpaper.is_file()]
        print(random.choice(wallpapers))

if __name__ == "__main__":
    app()
