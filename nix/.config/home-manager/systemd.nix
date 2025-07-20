{ pkgs, ... }:
{
  # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Sleep_hooks
  systemd.user.services.lock-session = {
    Unit = {
      Description = "Automatically lock the screen";
      Before = "sleep.target";
    };
    Install = {
      WantedBy = [ "sleep.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "/usr/bin/loginctl lock-session";
    };
  };
}