{ config, pkgs, ... }:

{
  networking = {
    hostName = "JellyCoast";
    firewall.allowedTCPPorts = [ 5600 8384 22000 ];
    firewall.allowedUDPPorts = [ 22000 ];
  };

  services.syncthing.guiAddress = "10.0.1.5:8384";

  environment.systemPackages = with pkgs; [
    btop
    fishPlugins.tide
    git
    gping
    micro
    neofetch
  ];

  system.stateVersion = "23.05";
}
