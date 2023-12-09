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
  
  services.deluge.enable = true;
  services.deluge.web.enable = true;
  services.jellyseerr.enable = true;
  services.lidarr.enable = true;
  services.radarr.enable = true;
  services.sonarr.enable = true;

  users.groups.multimedia.members = [
    "deluge"
    "lidarr"
    "radarr"
    "sonarr"
  ];

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
