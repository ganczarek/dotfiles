{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    history = {
      path = "$ZDOTDIR/.zsh_history";
      size = 10000000;
      save = 10000000;
      extended = true;
    };

    shellAliases = {
      gnuls = "/bin/ls";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      # tmux devs refuse to support XDG, so use an alias as a workaround (see https://github.com/tmux/tmux/issues/142)
      tmux = "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf";
      # pull and rebase all repositories you can list within current dir
      rg-git-pull-rebase-all = "ls | xargs -I % sh -xc 'cd % && git diff-index --quiet HEAD -- && git pull --rebase'";
      ssh = "TERM=xterm-256color ssh";
    };

    envExtra = ''
      export XDG_CONFIG_HOME="''$HOME/.config"
      export XDG_CACHE_HOME="''$HOME/.cache"
      export XDG_DATA_HOME="''$HOME/.local/share"

      export EDITOR="nvim"
      export PATH="''$HOME/.local/bin:''$HOME/.local/share/JetBrains/Toolbox/scripts:''$PATH"
      export NIX_PATH="''$HOME/.nix-defexpr/channels''${NIX_PATH:+:''$NIX_PATH}"

      export LANG="en_GB.UTF-8"
      # https://nixos.wiki/wiki/Locales
      export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
    '';

    initExtra = ''
      for file in ''$XDG_CONFIG_HOME/zsh/zsh.d/*; do source $file; done

      setopt hist_reduce_blanks # Remove superfluous blanks before recording entry.
    '';

  };

  # zsh init scripts
  home.file.".config/zsh/zsh.d".source = ./zsh.d;
  home.file.".config/zsh/zsh.d".recursive = true;

}
