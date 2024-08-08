{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [ 5055 5600 7878 8112 8989 ];
    firewall.allowedUDPPorts = [ ];
  };
  
  services.deluge = {
    enable = true;
    web.enable = true; # Port 8112
    datadir = "/filepit/deluge";
  };
  services.jellyseer.enable = true; # Port 5055
  services.radarr.enable = true; # Port 7878
  services.sonarr.enable = true; # Port 8989

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
