{ config, pkgs, ... }:

{
  networking = {
    hostName = "TanukiGrove";
    firewall.allowedTCPPorts = [ 5600 8384 22000 ];
    firewall.allowedUDPPorts = [ 22000 ];
  };

  services.syncthing.guiAddress = "10.0.1.10:8384";

  environment.systemPackages = with pkgs; [
    btop
    fishPlugins.tide
    git
    gping
    micro
    neofetch
  ];

  system.stateVersion = "23.11";
}
