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
    gpg
    fastfetch
    lazygit
    neofetch
    neovim
  ];

  system.stateVersion = "23.11";
}
