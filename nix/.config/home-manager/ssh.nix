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

      # Improve ssh security
      Protocol 2
      Ciphers aes256-ctr,aes128-ctr
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
    '';
  };
}