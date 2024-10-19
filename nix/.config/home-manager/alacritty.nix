{ pkgs, ... }:

{
  programs.alacritty.enable = true;
  # don't install Alacritty (use pacman package)
  programs.alacritty.package = pkgs.hello;
  programs.alacritty.settings = {
    font.size = 10.0;
  };
}