{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [
      5600  # SSH
      8384  # Syncthing web gui
      22000 # Syncthing syncing
    ];
    firewall.allowedUDPPorts = [ 22000 ];
  };

  services.syncthing.guiAddress = "10.0.1.13:8384";

  environment.systemPackages = with pkgs; [
    btop
    fishPlugins.tide
    git
    gping
    micro
    neofetch
    neovim
  ];

  system.stateVersion = "23.11";
}
