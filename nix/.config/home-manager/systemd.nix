{ pkgs, ... }:
{
  # https://wiki.archlinux.org/title/Session_lock#xautolock
  # https://wiki.archlinux.org/title/Power_management#Sleep_hooks
  systemd.user.services.i3lock = {
    Unit = {
      Description = "Automatically lock the screen";
      Before = "sleep.target";
    };
    Install = {
      WantedBy = [ "sleep.target" ];
    };
    Service = {
      User = builtins.getEnv "USER_ID";
      Type = "forking";
      Environment = "DISPLAY=:0";
      ExecStart = "/usr/bin/i3lock -c 000000";
    };
  };
}