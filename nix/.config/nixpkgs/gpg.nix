{ pkgs, config, ... }:

{
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.configHome}/gnupg";

    # content of gpg.conf
    settings = {
      keyserver = "hkp://keys.openpgp.net";
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 14400; # 4 hours
    maxCacheTtl = 28800; # 8 hours
    enableScDaemon = false;
    enableSshSupport = true;
    pinentryFlavor = null;
    extraConfig = ''
      pinentry-program /usr/bin/pinentry
    '';
  };
}
