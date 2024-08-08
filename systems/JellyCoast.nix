{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [ 5600 8096 8920 ];
    firewall.allowedUDPPorts = [ ];
  };

  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;

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
