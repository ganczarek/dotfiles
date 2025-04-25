# Configure Zsh Line Editor (C-x C-e like in Bash)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line