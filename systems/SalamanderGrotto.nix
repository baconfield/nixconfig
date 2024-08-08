{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [ 5055 5600 7878 8112 8686 8989 ];
    firewall.allowedUDPPorts = [ ];
  };

  users.groups.multimedia = { };
  
  services.deluge = {
    enable = true;
    web.enable = true; # Port 8112
    group = "multimedia";
    dataDir = "/filepit/deluge";
  };
  services.jellyseerr.enable = true; # Port 5055
  services.lidarr = { enable = true; group = "multimedia"; }; # Port 8686
  services.radarr = { enable = true; group = "multimedia"; }; # Port 7878
  services.sonarr = { enable = true; group = "multimedia"; }; # Port 8989

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
