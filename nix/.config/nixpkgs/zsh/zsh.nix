{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    
    shellAliases = {
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      vim = "nvim";
    };

    envExtra = ''
      export XDG_CONFIG_HOME="''$HOME/.config"
      export XDG_CACHE_HOME="''$HOME/.cache"
      export XDG_DATA_HOME="''$HOME/.local/share"

      export EDITOR="nvim"
      export PATH="''$HOME/.local/bin:''$PATH"
      export NIX_PATH="''$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels''${NIX_PATH:+:''$NIX_PATH}"

      export LANG="en_GB.UTF-8"
      # https://nixos.wiki/wiki/Locales
      export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

      export GPG_TTY=''$(tty)
    '';

    initExtra = ''
      for file in ''$XDG_CONFIG_HOME/zsh/zsh.d/*; do source $file; done
    '';

  };

  # zsh init scripts
  home.file.".config/zsh/zsh.d".source = ./zsh.d;
  home.file.".config/zsh/zsh.d".recursive = true;

}
