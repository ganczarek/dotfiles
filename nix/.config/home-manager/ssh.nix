{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # manually set "*" match block
    includes = [
        "config-*"
    ];

    extraConfig = ''
      #UseKeychain yes
      TCPKeepAlive yes
      StrictHostKeyChecking ask
      BatchMode no
      IdentitiesOnly yes
    '';

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        Compression = true;
        ServerAliveInterval = 30;
        ServerAliveCountMax = 3;
        ControlMaster = "auto";
        ControlPersist = "5m";
      };

      "github.com" = {
        User = "git";
        IdentityFile = "~/.ssh/github_ed25519"; 
      };
      
      "rpi4" = {
        Hostname = "192.168.1.197";
        User = "pi";
        Port = 2022;
        IdentityFile = "~/.ssh/rpi4_rsa";
      };
      
      "raspberrypi rpi4-tailscale" = {
        User = "pi";
        Port = 2022;
        IdentityFile = "~/.ssh/rpi4_rsa";
      };

      "asustor asustor-trailscale" = {
        User = "root";
        Port = 2022;
        IdentityFile = "~/.ssh/asustor_id_rsa";
      };

      "asustor-local" = {
        Hostname = "192.168.100.2";
        User = "root";
        Port = 2022;
        IdentityFile = "~/.ssh/asustor_id_rsa";
      };
    };
  };
}