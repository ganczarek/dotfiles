{ config, ... }:
{
  home.file."${config.xdg.dataHome}/dbus-1/services/org.freedesktop.secrets.service".text = ''
    [D-BUS Service]
    Name=org.freedesktop.secrets
    Exec=/usr/bin/keepassxc
  '';
}