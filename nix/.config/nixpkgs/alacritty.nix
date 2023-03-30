{ pkgs, ... }:

{
  programs.alacritty.enable = true;
  # don't install Alacritty (use pacman package)
  programs.alacritty.package = pkgs.hello;
  programs.alacritty.settings = {
    # Available values:
    # - full: borders and title bar
    # - none: neither borders nor title bar
    # - transparent: title bar, transparent background and title bar buttons
    # - buttonless: title bar, transparent background, but no title bar buttons
    window.declarations = "none";
    font.size = 10.0;
    dynamic_title = "true";
  };
}