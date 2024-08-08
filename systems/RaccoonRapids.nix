{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      5600  # SSH
      8384  # Syncthing web gui
      22000 # Syncthing tcp sync
    ];
    allowedUDPPorts = [ 
      22000 # Syncthing quic sync
      21027 # Syncthing discovery
    ];
  };

  services.syncthing.guiAddress = "10.0.1.13:8384";
  services.syncthing.group = "multimedia";
  users.groups.multimedia.members = [ "syncthing" ];

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
