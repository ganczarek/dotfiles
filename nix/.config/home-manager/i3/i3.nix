{ config, pkgs, ... }:

let
  configFile = ./config;
  checkI3Config =
    pkgs.runCommandLocal "i3-config" { buildInputs = [ pkgs.i3 ]; }  ''
      # We have to make sure the wrapper does not start a dbus session
      export DBUS_SESSION_BUS_ADDRESS=1

      # A zero exit code means i3 successfully validated the configuration
      i3 -c ${configFile} -C -d all || {
        echo "i3 configuration validation failed"
        echo "For a verbose log of the failure, run 'i3 -c ${configFile} -C -d all'"
        exit 1
      };
      cp ${configFile} $out
    '';
in {

  xdg.configFile."i3/config" = {
    source = checkI3Config;
    onChange = ''
      # There may be several sockets after log out/log in, but the old ones
      # will fail with "Connection refused".
      for i3Socket in ''${XDG_RUNTIME_DIR:-/run/user/$UID}/i3/ipc-socket.*; do
        if [[ -S $i3Socket ]]; then
          echo "Reload $i3Socket"
          i3-msg -s $i3Socket reload >/dev/null |& grep -v "Connection refused" || true
        fi
      done
    '';
  };
  home.file.".config/i3/i3blocks.conf".source = ./i3blocks.conf;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
  };
}
