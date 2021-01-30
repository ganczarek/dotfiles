typeset -g ZPLG_MOD_DEBUG=1

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

zinit wait lucid for atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting

# adds color to man pages
zinit ice lucid nocompile && zinit load MenkeTechnologies/zsh-very-colorful-manuals

zinit wait lucid for OMZL::git.zsh OMZP::git

export ENHANCD_FILTER=fzf
export ENHANCD_DISABLE_DOT=1 # don't use interactive filter with '..'
zinit wait lucid for b4b4r07/enhancd

# init fasd and add few aliases
zinit wait lucid for OMZP::fasd
# z tab completion with fzf search and fasd
zinit wait lucid for wookayin/fzf-fasd

zinit wait lucid for \
  OMZP::aws \
  OMZP::gcloud \
  OMZP::mvn \
  OMZP::sbt \
  as"completion" OMZP::scala/_scala \
  as"completion" OMZP::docker/_docker \
  OMZP::docker-compose \
  OMZP::pip

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
  zsh-users/zsh-completions

