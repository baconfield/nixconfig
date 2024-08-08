{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      5001 # Dockge
      5600 # SSH
    ];
    allowedUDPPorts = [
    ];
  };

  virtualisation.docker.enable = true;
  users.users.tjcater.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    btop
    fishPlugins.tide
    git
    gping
    micro
    neofetch
    s-tui
  ];

  system.stateVersion = "23.11";
}
