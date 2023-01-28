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
    if [[ "$(groups)" != *nix-users* ]]; then
        echo "Enabling nix-daemon service"
        sudo systemctl enable nix-daemon.service
        echo "Starting nix-daemon servie"
        sudo systemctl start nix-daemon.service
        sudo gpasswd -a $USER nix-users
        echo "Adding trusted-user to global nix configuration"
        sudo tee -a /etc/nix/nix.conf > /dev/null << EOF        
# Added by $0
trusted-users = $USER
EOF
        echo
        echo "  Nix configuration requires user to log out and log in again."
        echo "  Press $mod+Shift+e in i3wm"
        echo
        exit
    fi

    nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    nix-channel --update
}

install_home_manager() {
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
    nix-channel --update
    # NIX_PATH is needed to install home-manager before we configure shell with all env variables
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install
}

ARCH_PACKAGES=(
    nix
    stow
    tig
    alacritty
)

sudo pacman -S --needed --noconfirm "${ARCH_PACKAGES[@]}"

stow --target="$HOME" nix
configure_nix
install_home_manager
