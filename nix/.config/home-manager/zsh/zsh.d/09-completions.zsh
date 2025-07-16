zinit wait lucid blockf for zsh-users/zsh-completions

## fzf-tab needs to be loaded after compinit, but before zsh-autosuggestions or fast-syntax-highlighting
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zinit wait lucid atinit"zicompinit; zicdreplay" for Aloxaf/fzf-tab

# make suggestions visible with solarized-dark theme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#657b83"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
zinit wait lucid for atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

# based on https://serverfault.com/questions/170346/how-to-edit-command-completion-for-ssh-on-zsh/170481#170481
h=()
for file in ~/.ssh/config*; do
  h=($h ${${${(@M)${(f)"$(cat $file)"}:#Host *}#Host }:#*[*?]*})
done
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

zinit wait lucid for zdharma/fast-syntax-highlighting

zinit ice if'command -v uv >/dev/null 2>&1'; zinit ice atload'eval "$(uv generate-shell-completion zsh)"'

# GitLab CLI
zinit ice if'command -v glab >/dev/null 2>&1'; zinit ice atload'glab completion -s zsh > "${fpath[1]}/_glab"'