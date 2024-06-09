if status is-interactive
    # Environment variables
    set -xg EDITOR nvim
    set -xg VISUAL nvim

    # Extra paths
    fish_add_path -g "/etc/profiles/per-user/$USER/bin/"
    fish_add_path -g "/run/current-system/sw/bin/"

    # TODO: Remove this (?)
    fish_add_path -g "/usr/local/bin/"
    fish_add_path -g "$HOME/.local/bin/"
    fish_add_path -g "/opt/texlive/2023/bin/x86_64-linux/"

    # Source scripts
    starship init fish | source
    enable_transience

    zoxide init fish | source

    # Abbreviation
    abbr --add kpi "sudo xbps-install -S"
    abbr --add kpr "sudo xbps-remove -R"
    abbr --add v "nvim"
    abbr --add ls "eza --icons --git"
    abbr --add tree "eza --icons --git --tree"
    abbr --add sorry "sudo $history[1]"
    abbr --add cd "z"
end
