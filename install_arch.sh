#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

if [[ ! -f "/usr/lib/endeavouros-release" ]]; then
    echo "Endeavour OS (Arch) not detected. Exiting..."
    exit 1
fi

DOTFILES_DIR="$HOME/.dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
    git clone https://github.com/ganczarek/dotfiles.git $DOTFILES_DIR
fi

configure_nix() {
    echo "Enabling nix-daemon service"
    sudo systemctl enable nix-daemon.service
    echo "Starting nix-daemon servie"
    sudo systemctl start nix-daemon.service

    nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    nix-channel --update
}

install_home_manager() {
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    # NIX_PATH is needed to install home-manager before we configure shell with all env variables
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install
}

# From oh-my-zsh installation script
change_shell_to_zsh_if_not_already_changed() {
    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
        # If this platform provides a "chsh" command (not Cygwin), do it, man!
        if hash chsh >/dev/null 2>&1; then
            if [ "$(uname)" == "Darwin" ]; then
                echo "Install the latest version of zsh with Homebrew"
                brew install zsh
                # Change shell to zsh!
                ZSH_LOCAL="/usr/local/bin/zsh"
                grep "${ZSH_LOCAL}" /etc/shells || \
                    (echo "Add ${ZSH_LOCAL} to /etc/shells" && sudo sh -c "echo '${ZSH_LOCAL}' >> /etc/shells")
                chsh -s ${ZSH_LOCAL}
            else
                printf "Time to change your default shell to zsh!\n"
                chsh -s $(grep /zsh$ /etc/shells | tail -1)
            fi
        # Else, suggest the user do so manually.
        else
          printf "I can't change your shell automatically because this system does not have chsh.\n"
          printf "Please manually change your default shell to zsh!\n"
        fi
    fi
}

install_zinit() {
  ZINIT_HOME=~/.zinit
  if ! test -d "$ZINIT_HOME"; then
    mkdir $ZINIT_HOME
    chmod og-w $ZINIT_HOME

    git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME/bin
  fi
}

configure_etc() {
  find etc -type f -exec sudo cp --verbose --no-clobber {} /{} \;
}

configure_nvidia() {
  if command -v envycontrol >/dev/null 2>&1; then
    sudo envycontrol -s hybrid --rtd3
    sudo systemctl enable nvidia-suspend.service
    sudo systemctl enable nvidia-hibernate.service
    sudo systemctl enable nvidia-resume.service
  fi
}

configure_tongfang() {
  local board_name_file="/sys/class/dmi/id/board_name"
  local board_name="GM5MPHW"

  if [[ -f "$board_name_file" && -r "$board_name_file" ]]; then
      if [[ "$(cat "$board_name_file" | head -n 1 | tr -d '\n\r')" == "$board_name" ]]; then
          yay -Sy --needed tuxedo-control-center-bin
      fi
  fi
}

ARCH_PACKAGES=(
    # pre-config dependencies
    nix
    stow

    # terminal and shell
    zsh
    eza
    fzf
    fasd
    htop
    alacritty
    tig
    difftastic
    github-cli
    direnv

    libfido2
    yubikey-manager
    jre-openjdk
    obsidian
    autorandr

    xf86-input-wacom

    docker
    docker-compose

    # i3 Window Manager
    i3-wm
    i3blocks
    i3lock
    i3status
    autotiling-rs
    feh
)

AUR_PACKAGES=(
    jetbrains-toolbox
)

sudo pacman -Sy --needed --noconfirm "${ARCH_PACKAGES[@]}"
yay -Sy --needed "${AUR_PACKAGES[@]}"

stow --target="$HOME" nix
configure_nix
configure_nvidia
configure_etc
configure_tongfang
install_zinit
change_shell_to_zsh_if_not_already_changed
install_home_manager
home-manager switch
