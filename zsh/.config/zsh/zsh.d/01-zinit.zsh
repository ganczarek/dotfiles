declare -A ZINIT
export ZINIT[HOME_DIR]="$HOME/.zinit"
export ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
export ZINIT[ZCOMPDUMP_PATH]="$ZINIT[HOME_DIR]/zcompdump"

source $ZINIT[BIN_DIR]/zinit.zsh