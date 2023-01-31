{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    
    shellAliases = {
      gnuls = "/bin/ls";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      # tmux devs refuse to support XDG, so use an alias as a workaround (see https://github.com/tmux/tmux/issues/142)
      tmux = "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf";
      # pull and rebase all repositories you can list within current dir
      rg-git-pull-rebase-all = "ls | xargs -I % sh -xc 'cd % && git diff-index --quiet HEAD -- && git pull --rebase'";
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
