# tmux devs refuse to support XDG, so use an alias as a workaround (see https://github.com/tmux/tmux/issues/142)
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'