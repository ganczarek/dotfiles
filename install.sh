#!/usr/bin/env bash

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

is_mac() {
  [ "$(uname)" == "Darwin" ]
}

install() {
  COMMAND=$1
  BREW_PACKAGE=${2:-$COMMAND}
  PACMAN_PACKAGE=${3:-$BREW_PACKAGE}
  if ! command_exists $COMMAND; then
    echo "Installing $COMMAND (MacOS: $BREW_PACKAGE, Arch: $PACMAN_PACKAGE)"
    if is_mac; then
      brew install $BREW_PACKAGE
    else
      sudo pacman -S $PACMAN_PACKAGE
    fi
  fi
}

# inspired by oh-my-zsh installation script
change_shell_to_zsh_if_not_already_changed() {
  if [ "$(basename -- "$SHELL")" = "zsh" ]; then
    return
  fi

  if command_exists chsh; then
    echo "Shell can't be changed automatically, because system does not have chsh."
    exit 1
  fi

  install zshen zsh

  ZSH_BIN_PATH=$(grep /zsh /etc/shells | tail -1)
  echo "Use chsh to change shell to $ZSH_BIN_PATH"
  if ! chsh -s "$ZSH_BIN_PATH"; then
    echo "chsh failed to change shell to zsh!"
    exit 1
  fi

}

install_zinit() {
  install git

  ZINIT_HOME=~/.zinit
  if ! test -d "$ZINIT_HOME"; then
    mkdir $ZINIT_HOME
    chmod og-w $ZINIT_HOME

    git clone https://github.com/ganczarek/zinit.git $ZINIT_HOME/bin
  fi
}

setup_gpg_agent() {
  # Needed so that gpg-agent.conf can be shared between MacOS and Arch Linux
  if is_mac; then
    if [ -e /usr/local/bin/pinentry-mac ] && [ ! -e /usr/local/bin/pinentry-crossplatform ]; then
      echo "Link GnuPG pinentry for Mac"
      sudo ln -s /usr/local/bin/pinentry-mac /usr/local/bin/pinentry-crossplatform
    fi
  else
    if [ -e /usr/bin/pinentry ] && [ ! -e /usr/local/bin/pinentry-crossplatform ]; then
      echo "Link GnuPG pinentry for Arch"
      sudo ln -s /usr/bin/pinentry /usr/local/bin/pinentry-crossplatform
    fi
  fi
}



change_shell_to_zsh_if_not_already_changed
install_zinit
setup_gpg_agent
install exa
install fzf
install fasd

stow zsh
stow git
stow tig
stow gnupg
stow tmux
stow termite
