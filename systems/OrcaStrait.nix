{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
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
    gnupg
    fastfetch
    lazygit
    neofetch
    neovim
    pinentry-curses
  ];

  system.stateVersion = "23.11";
}
