# tmux devs refuse to support XDG, so use an alias as a workaround (see https://github.com/tmux/tmux/issues/142)
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'

if command -v exa >/dev/null 2>&1; then
  alias gnuls='/bin/ls'
  alias la='exa -a'
  alias ll='exa -al'
  alias ls='exa'
fi
