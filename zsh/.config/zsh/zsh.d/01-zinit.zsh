typeset -g ZPLG_MOD_DEBUG=1

declare -A ZINIT
export ZINIT[HOME_DIR]="$HOME/.zinit"
export ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
export ZINIT[ZCOMPDUMP_PATH]="$ZINIT[HOME_DIR]/zcompdump"

source $ZINIT[BIN_DIR]/zinit.zsh

# adds color to man pages
zinit ice lucid nocompile && zinit load MenkeTechnologies/zsh-very-colorful-manuals

# LS_COLORS is used by fzf-tab
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

zinit wait lucid nocompletions for OMZP::git

export ENHANCD_FILTER=fzf
export ENHANCD_DISABLE_DOT=1 # don't use interactive filter with '..'
zinit wait lucid for b4b4r07/enhancd

# init fasd and add few aliases
zinit wait lucid for OMZP::fasd
# z tab completion with fzf search and fasd
zinit wait lucid for wookayin/fzf-fasd

zinit wait lucid for OMZP::aws # AWS plugin (e.g. acp command to change profiles)
export SHOW_AWS_PROMPT=false   # let Spaceship to add AWS profile to the prompt