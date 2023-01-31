{ pkgs, ... }:

{
  programs.gh = {
    enable = true;
    package = pkgs.hello;
    extensions = [
      pkgs.gh-dash
    ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
}
