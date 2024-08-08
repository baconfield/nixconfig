{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      5055 # Jellyseerr
      5600 # SSH
      7878 # Radarr
      8112 # Deluge
      8686 # Lidarr
      8989 # Sonarr
    ];
  };
  
  services.deluge = {
    enable = true;
    web.enable = true;
    group = "multimedia";
    dataDir = "/filepit/deluge";
  };
  services.jellyseerr.enable = true;
  services.lidarr = { enable = true; group = "multimedia"; };
  services.radarr = { enable = true; group = "multimedia"; };
  services.sonarr = { enable = true; group = "multimedia"; };

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
