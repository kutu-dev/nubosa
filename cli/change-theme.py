import argparse
from pathlib import Path
from platformdirs import user_documents_dir


NUBOSA_PATH = Path(user_documents_dir()) / "dev/nubosa"


def main() -> None:
    parser = argparse.ArgumentParser(description="Theme manager for Nubosa")
    parser.add_argument("theme_name", help='The name of the theme to apply')

    args = parser.parse_args()
    print(args.theme_name)


if __name__ == "__main__":
    main()
