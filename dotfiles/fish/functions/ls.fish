function ls --wraps=eza --wraps='eza --icons --git' --description 'alias ls=eza --icons --git'
  command eza --icons --git -g $argv
end
