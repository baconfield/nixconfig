{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [
      5600 # SSH
      4533 # Navidrome
      8096 # Jellyfin http
      8920 # Jellyfin https
    ];
    firewall.allowedUDPPorts = [ ];
  };

  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
  services.navidrome.enable = true;
  services.navidrome.settings.MusicFolder = "/filepit/music";

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
