zinit wait lucid blockf for zsh-users/zsh-completions

## fzf-tab needs to be loaded after compinit, but before zsh-autosuggestions or fast-syntax-highlighting
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zinit wait lucid atinit"zicompinit; zicdreplay" for Aloxaf/fzf-tab

# make suggestions visible with solarized-dark theme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#657b83"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
zinit wait lucid for atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

zinit wait lucid for zdharma/fast-syntax-highlighting