{
  programs.ssh = {
    enable = true;
    includes = [
        "config-*"
    ];
    addKeysToAgent = "yes";
    compression = true;
    serverAliveInterval = 30;
    serverAliveCountMax = 3;

    controlMaster = "auto";
    controlPersist = "5m";

    extraConfig = ''
      #UseKeychain yes
      TCPKeepAlive yes
      StrictHostKeyChecking ask
      BatchMode no
      IdentitiesOnly yes
    '';

    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github_ed25519"; 
      };
      
      "rpi4" = {
        hostname = "192.168.1.197";
        user = "pi";
        port = 2022;
        identityFile = "~/.ssh/rpi4_rsa";
      };
      
      "raspberrypi rpi4-tailscale" = {
        user = "pi";
        port = 2022;
        identityFile = "~/.ssh/rpi4_rsa";
      };

      "asustor asustor-trailscale" = {
        user = "root";
        port = 2022;
        identityFile = "~/.ssh/asustor_id_rsa";
      };

      "asustor-local" = {
        hostname = "192.168.100.2";
        user = "root";
        port = 2022;
        identityFile = "~/.ssh/asustor_id_rsa";
      };
    };
  };
}