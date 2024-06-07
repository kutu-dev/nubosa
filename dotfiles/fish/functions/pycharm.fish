function pycharm --wraps='flatpak run com.jetbrains.PyCharm-Professional' --description 'alias pycharm=flatpak run com.jetbrains.PyCharm-Professional'
    flatpak run com.jetbrains.PyCharm-Professional $argv >/dev/null 2>&1 & disown
end
