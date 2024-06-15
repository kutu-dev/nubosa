function n --wraps nnn --description 'support nnn quit and change directory'
    # Avoid block nesting of nnn in subshells
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo "nnn is already running"
        return
    end

    # Configuration variables
    set -fx NNN_OPTS "exa"
    set -fx NNN_BMS "d:$HOME/documents;v:$HOME/documents/dev"
    set -fx NNN_PLUG 'p:preview-tui;c:!code-oss $(dirname $nnn)*;l:fzplug;i:!feh $(dirname $nnn)*'

    # Set up cd on exit
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
end
