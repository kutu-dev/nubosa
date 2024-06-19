from colorama import Fore, Back, Style

def error(message: str) -> None:
    print(f"{Style.BRIGHT}{Fore.RED}ERROR{Style.RESET_ALL}: {message}")


def warning(message: str) -> None:
    print(f"{Style.BRIGHT}{Fore.YELLOW}WARNING{Style.RESET_ALL}: {message}")
