zinit wait lucid for OMZL::history.zsh

zinit load zdharma/history-search-multi-word

export HIST_STAMPS="yyyy-mm-dd"
export HISTSIZE=100000
export HISTFILESIZE=100000

setopt hist_reduce_blanks # Remove superfluous blanks before recording entry.
