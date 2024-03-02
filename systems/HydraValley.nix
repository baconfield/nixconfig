{ config, pkgs, ... }:

{
  networking.hostName = "HydraValley";
  networking.firewall.allowedTCPPorts = [
    5001 # Dockge
    5600 # SSH
  ];
  networking.firewall.allowedUDPPorts = [];

  environment.systemPackages = with pkgs; [
    inxi
    bottom
    btop
    curl
    fastfetch
    fishPlugins.tide
    gcc
    git
    micro
    nano
    s-tui
    wget
    vim
  ];

  virtualisation.docker.enable = true;
  users.users.tjcater.extraGroups = [ "docker" ];

  system.stateVersion = "23.11";
}
