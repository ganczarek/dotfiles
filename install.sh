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
  install_macos $COMMAND $BREW_PACKAGE
  install_linux $COMMAND $PACKMAN_PACKAGE
}

install_macos() {
  COMMAND=$1
  BREW_PACKAGE=${2:-$COMMAND}
  if is_mac && ! command_exists $COMMAND; then
    echo "Installing $COMMAND (brew package: $BREW_PACKAGE)"
    brew install $BREW_PACKAGE
  fi
}

install_linux() {
  COMMAND=$1
  PACMAN_PACKAGE=${2:-$COMMAND}
  PACKAGE_MANAGER=${3:-sudo pacman}
  if ! is_mac && ! command_exists $COMMAND; then
    echo "Installing $COMMAND (package: $PACMAN_PACKAGE)"
    $PACKAGE_MANAGER -S $PACMAN_PACKAGE
  fi
}

install_aur() {
  COMMAND=$1
  AUR_PACKAGE=${2:-$COMMAND}
  install_linux $COMMAND $AUR_PACKAGE yay
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
      ln -s /usr/local/bin/pinentry-mac /usr/local/bin/pinentry-crossplatform
    fi
  else
    if [ -e /usr/bin/pinentry ] && [ ! -e /usr/local/bin/pinentry-crossplatform ]; then
      echo "Link GnuPG pinentry for Arch"
      sudo ln -s /usr/bin/pinentry /usr/local/bin/pinentry-crossplatform
    fi
  fi
}

install_home_manager() {
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
}

change_shell_to_zsh_if_not_already_changed
install_zinit

install_macos pinentry-mac
install_linux pinentry
setup_gpg_agent

install exa
install fzf
install fasd
install_macos reattach-to-user-namespace
install_linux xclip
install stow
install tmux
install tig
install nvim
install_macos asdf
install_aur asdf asdf-vm
install alacritty
install difftastic
install_linux nix

install gpg gnupg
#chown -R "$(whoami)" ~/.gnupg/
#chmod 600 ~/.gnupg/*
#chmod 700 ~/.gnupg

stow --target="$HOME" zsh
stow --target="$HOME" git
stow --target="$HOME" tig
stow --target="$HOME" gnupg
stow --target="$HOME" tmux

if ! is_mac; then
  stow --target="$HOME" X11
  stow --target="$HOME" nix
  stow --target="$HOME" i3
else
  stow --target="$HOME" iterm2
  sh ./osx/defaults.sh
fi

install_home_manager
home-manager switch
