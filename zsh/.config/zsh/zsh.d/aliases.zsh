# tmux devs refuse to support XDG, so use an alias as a workaround (see https://github.com/tmux/tmux/issues/142)
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'

if command -v exa >/dev/null 2>&1; then
  alias gnuls='/bin/ls'
  alias la='exa -a'
  alias ll='exa -al'
  alias ls='exa'
fi

# pull and rebase all repositories you can list within current dir
alias rg-git-pull-rebase-all="ls | xargs -I % sh -xc 'cd % && git diff-index --quiet HEAD -- && git pull --rebase'"