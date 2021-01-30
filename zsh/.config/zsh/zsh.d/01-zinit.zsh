declare -A ZINIT
export ZINIT[HOME_DIR]="$HOME/.zinit"
export ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
export ZINIT[ZCOMPDUMP_PATH]="$ZINIT[HOME_DIR]/zcompdump"

source $ZINIT[BIN_DIR]/zinit.zsh

# make suggestions visible with solarized-dark theme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#657b83"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
zinit wait lucid for atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

