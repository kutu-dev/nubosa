if status is-interactive
    # Environment variables
    set -xg EDITOR nvim
    set -xg VISUAL nvim

    # Extra paths
    fish_add_path -g "/etc/profiles/per-user/$USER/bin/"
    fish_add_path -g "$HOME/.nix-profile/bin"
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

  # # Nix abbreviations
    abbr -a nd 'nix develop -c "fish"'
    abbr -a --set-cursor="cursor" ns 'nix shell nixpkgs#cursor --command "fish"'

    # Git abbreviations
    abbr -a gs "git status"
    abbr -a ga "git add ."
    abbr -a --set-cursor="cursor" gc 'git commit -m "cursor"'
    abbr -a --set-cursor="cursor" gac 'git commit -am "cursor"'
    abbr -a gp "git push origin"

    # Emulate the `!!` syntax from `bash`
    function last_history_item
      echo $history[1]
    end

    abbr -a --position anywhere --function last_history_item !!

    # Add ssh agent environment variable manually
    # as fish does not source the Home Manager file
    # if config is set as a symlink
    
    set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent
end
