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
  services.navidrome = {
    enable = true;
    settings.Address = "10.0.1.14";
    settings.MusicFolder = "/Filepit/Music";
  };

  users.groups.rendering = {
    gid = 104;
    members = [ "jellyfin" ];
  };

  users.groups.multimedia.members = [
    "navidrome"
    "jellyfin"
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965
    ];
  };

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
