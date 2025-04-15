# Dotfiles

This is a set of configuration files and scripts I use to customize my Linux and OS X systems.

I have migrated most of the configuration to Nix's [Home Manager](https://github.com/nix-community/home-manager) though
I don't use NixOS. Time will tell if I regret that decision.

# How to use

You should perhaps use this repository as a reference, rather than applying
all changes to your system directly, but here's what I do.

## Installation

```bash
git clone https://github.com/ganczarek/dotfiles ~/.dotfiles
cd ~/.dotfiles
sh install_arch.sh
```

Installation script rarely needs re-running as most configuration is handled by Home Manager.

## Home Manager

### Update configuration

```bash
home-manager switch
```

### Testing changes before activation

```bash
home-manager build

# inspect the output in result/ directory

# if all ok, activate the change
./result/activate
```

### Rollback

1. List all available generations

```bash
home-manager generations
```

2. Rollback to selected generation by activating it. For example:

```bash
/nix/store/21asgwplshcpw58bvz0nccdv82yqvg5v-home-manager-generation/activate
```

You can delete older generations using `home-manager expire-generations` command.

### Updating Home Manager

```bash
nix-channel --update
home-manager switch
```

Note: Above will update all Nix channels (so both `home-manager` and `nixpkgs`).