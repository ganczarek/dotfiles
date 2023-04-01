{ ... }:

{
  # don't start X sessio with Nix
  xsession.enable = false;

  home.file.".xprofile".source = ./xprofile;
  home.file.".Xmodmap".source = ./Xmodmap;
}
