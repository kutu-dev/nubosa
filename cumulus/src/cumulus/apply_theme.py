from .state import State
from .logging import error

from pathlib import Path
import os
from multiprocessing import Process
import time
import sys
from jinja2 import Environment, PackageLoader
import yaml
import tomllib
from platformdirs import user_documents_dir
from colorama import Fore, Style
import shutil
import subprocess


# Bad trick to make a valid environment for both when the package is installed
# or it's just being called to the local module `python3 -m src.cumulus`
try:
    ENVIRONMENT = Environment(
        loader=PackageLoader("cumulus"),
    )
except ModuleNotFoundError:
    ENVIRONMENT = Environment(
        loader=PackageLoader("__main__"),
    )

def apply_template(template_name: str, target_file_path: Path, **variables) -> None:
    print(f"  - Applying template: {Fore.BLUE}{template_name}{Style.RESET_ALL}")

    template = ENVIRONMENT.get_template(f"{template_name}.jinja")
    rendered_template = template.render(
        **variables
    )

    target_file_path.touch()
    with open(target_file_path, "w") as file:
        file.write(rendered_template)

def apply_nvim(theme_path: Path, dotfiles_path: Path) -> None:
    manifest_path = theme_path / "manifest.toml"

    if not manifest_path.is_file():
        error(f"Manifest file not found at \"{manifest_path}\"")
        return

    with open(manifest_path, "rb") as file:
        theme_manifest = tomllib.load(file)
        print(f"Loading theme: {theme_manifest["name"]}")

        apply_template("nvim-set-package",  dotfiles_path / "nvim/lua/plugins/theme.lua", **theme_manifest)
        apply_template("nvim-set-colorscheme",  dotfiles_path / "nvim/lua/core/style.lua", **theme_manifest)

def apply_base_16(theme_path: Path, nubosa_path: Path, dotfiles_path: Path) -> None:
    with open(theme_path / "base-16.yaml", "r") as file:
        base_16_data = yaml.safe_load(file)

        templates = [
            ("wezterm", dotfiles_path / "wezterm/colors/theme.toml"),
            ("btop", dotfiles_path / "btop/themes/theme.theme"),
            ("firefox-user-content", nubosa_path / "modules/common/programs/firefox/user-content.nix"),
            ("firefox-user-chrome", nubosa_path / "modules/common/programs/firefox/user-chrome.nix"),
            ("ags", dotfiles_path / "ags/style.css"),
            ("vesktop", dotfiles_path / "vesktop/themes/theme.css"),
        ]

        for template_name, template_path in templates:
            apply_template(
                template_name,
                template_path,
                **base_16_data,
            )

def apply_stylix(theme_path: Path, nubosa_path: Path, dotfiles_path: Path) -> None:
    print(f"  - Rebuilding {Fore.BLUE}Stylix{Style.RESET_ALL} based files...")
    print(f"      - Running Home Manager switch, it may take some time....")
    shutil.copy(
        theme_path / "base-16.yaml",
        dotfiles_path / "stylix/theme.yaml",
    )

    subprocess.run(
        ["just", "switch-home"],
        cwd = nubosa_path,
    )

def save_applied_theme(theme_name, data_path: Path) -> None:
    applied_theme_info_path = data_path / "applied-theme.txt"
    applied_theme_info_path.touch()

    with open(applied_theme_info_path, "w") as file:
        file.write(theme_name + "\n")

def reopen_wezterm() -> None:
    # Do a double fork
    if os.fork() != 0:
        return

    if os.fork() != 0:
        return

    os.setsid()

    sys.stdin.flush()
    sys.stdout.flush()
    sys.stderr.flush()

    null = os.open(os.devnull, os.O_RDWR)
    os.dup2(null, sys.stdin.fileno())
    os.dup2(null, sys.stdout.fileno())
    os.dup2(null, sys.stderr.fileno())
    os.close(null)

    time.sleep(0.1)
    subprocess.run(["wezterm"])

def restart_apps() -> None:
    print("  - Killing affected apps...")

    reopen_wezterm()

    for process in ["firefox", "wezterm"]:
        print(f"     - Killing \"{Fore.MAGENTA}{process}{Style.RESET_ALL}\"")
        subprocess.run(["pkill", process])

def apply_theme(theme_name: str, state: State) -> None:
    theme_path = state.config_path / theme_name

    if not theme_path.is_dir():
        error("Theme not found")
        sys.exit(1)

    nubosa_path = Path(user_documents_dir()) / "dev/nubosa"
    dotfiles_path = nubosa_path / "dotfiles"

    apply_nvim(theme_path, dotfiles_path)
    apply_base_16(theme_path, nubosa_path, dotfiles_path)
    apply_stylix(theme_path, nubosa_path, dotfiles_path)

    save_applied_theme(theme_name, state.data_path)

    restart_apps()