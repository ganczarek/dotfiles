#!/usr/bin/env bash

# inspired by oh-my-zsh installation script
change_shell_to_zsh_if_not_already_changed() {
  if [ "$(basename -- "$SHELL")" = "zsh" ]; then
    return
  fi

  if ! command -v chsh >/dev/null 2>&1; then
    echo "Shell can't be changed automatically, because system does not have chsh."
    exit 1
  fi

  if ! command -v zsh &>/dev/null; then
    if [ "$(uname)" == "Darwin" ]; then
      echo "Install the latest version of zsh with Homebrew"
      brew install zsh
    elif command -v pacman &>/dev/null; then
      echo "Install the latest version of zsh with Pacman"
      sudo pacman -S zsh
    else
      echo "Unsupported system without zsh. Install zsh manually or update the script."
      exit 1
    fi
  fi

  ZSH_BIN_PATH=$(grep /zsh /etc/shells | tail -1)
  echo "Use chsh to change shell to $ZSH_BIN_PATH"
  if ! chsh -s "$ZSH_BIN_PATH"; then
    echo "chsh failed to change shell to zsh!"
    exit 1
  fi

}

install_zinit() {
  if ! command -v git >/dev/null 2>&1; then
    echo "You need git to install zinit (zsh plugin manager)!"
    exit 1
  fi

  ZINIT_HOME=~/.zinit
  if ! test -d "$ZINIT_HOME"; then
    mkdir $ZINIT_HOME
    chmod og-w $ZINIT_HOME

    git clone https://github.com/ganczarek/zinit.git $ZINIT_HOME/bin
  fi
}

setup_gpg_agent() {
  # Needed so that gpg-agent.conf can be shared between MacOS and Arch Linux
  if [ "$(uname)" == "Darwin" ]; then
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

stow zsh
stow git
stow tig
stow gnupg
stow tmux