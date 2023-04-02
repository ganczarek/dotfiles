{ pkgs, ... }:

let
  wacom2monitor = pkgs.writeScriptBin "wacom2monitor" (builtins.readFile ./wacom2monitor.sh);
in {
  home.packages = [
    wacom2monitor
  ];
}
