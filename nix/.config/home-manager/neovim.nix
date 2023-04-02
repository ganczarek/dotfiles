{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];

    extraConfig = ''
    '';
  };
}
