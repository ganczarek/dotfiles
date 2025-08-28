{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rafal";
  home.homeDirectory = "/home/rafal";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./alacritty.nix
    ./arandr.nix
    ./git.nix
    ./tig.nix
    ./github-cli.nix
    ./gpg.nix
    ./ssh.nix
    ./i3/i3.nix
    ./keepassxc.nix
    ./neovim.nix
    ./zsh/zsh.nix
    ./wacom/wacom.nix
    ./xsession/xsession.nix
    ./systemd.nix
  ];

  nixpkgs.overlays = [
    # use packages installed by pacman
    (self: super: { zsh = pkgs.hello; autorandr = pkgs.hello; })
  ];

  services = {
    lorri = {
      enable = true;
    }; 
  };

  home.packages = with pkgs; [
    jira-cli-go
  ];
}
