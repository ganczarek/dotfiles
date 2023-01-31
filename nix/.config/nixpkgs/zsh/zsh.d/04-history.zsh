zinit snippet OMZL::history.zsh

zinit wait lucid for zdharma/history-search-multi-word

export HIST_STAMPS="yyyy-mm-dd"
export HISTSIZE=10000000
export HISTFILESIZE=10000000

setopt hist_reduce_blanks # Remove superfluous blanks before recording entry.
