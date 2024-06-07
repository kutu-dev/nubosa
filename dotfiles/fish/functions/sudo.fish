function sudo -w sudo --description 'Replacement for Bash "sudo !!" command to run the last command with sudo'
    if test "$argv" = !!
        printf %s\\n "sudo $history[1]"
        command sudo $(string split " " $history[1])
    else
        command sudo $argv
    end
end
