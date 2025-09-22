{ pkgs, config, ... }:

{
  programs.gpg = {
    enable = true;
    package = pkgs.hello;
    homedir = "${config.xdg.configHome}/gnupg";

    # content of gpg.conf
    settings = {
      keyserver = "hkp://keys.openpgp.net";
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 14400; # 4 hours (resets each time key is used)
    maxCacheTtl = 43200; # 12 hours (max time key can be cached)
    enableScDaemon = false;
    enableSshSupport = false;
    pinentry = {
        package = null;
    };
    extraConfig = ''
      pinentry-program /usr/bin/pinentry-curses
    '';
  };
}
