source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

for file in $XDG_CONFIG_HOME/zsh/zsh.d/*; do source $file; done

[ -f $XDG_CONFIG_HOME/zsh/.zshrc.local ] && source $XDG_CONFIG_HOME/zsh/.zshrc.local