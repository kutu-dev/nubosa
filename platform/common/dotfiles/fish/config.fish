if status is-interactive
    # Environment variables
    set -xg EDITOR nvim
    set -xg VISUAL nvim

    # Extra paths
    fish_add_path -g "/etc/profiles/per-user/$USER/bin/"
    fish_add_path -g "$USER/.nix-profile/bin"
    fish_add_path -g "/run/current-system/sw/bin/"
    fish_add_path -g "/run/wrappers/bin"

    # Source scripts
    starship init fish | source
    enable_transience

    zoxide init fish | source

    # General abbreviations
    abbr -a v "nvim"
    abbr -a ls "eza --icons --git"
    abbr -a tree "eza --icons --git --tree"
    abbr -a cd "z"

    # Git abbreviations
    abbr -a ga "git add ."
    abbr -a --set-cursor="cursor" gc 'git commit -m "cursor"'
    abbr -a --set-cursor="cursor" gac 'git commit -am "cursor"'
    abbr -a gp "git push origin"

    # Emulate the `!!` syntax from `bash`
    function last_history_item
      echo $history[1]
    end

    abbr -a --position anywhere --function last_history_item !!
end
