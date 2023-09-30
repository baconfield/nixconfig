{ config, pkgs, ... }:

{
  networking = {
    firewall.allowedTCPPorts = [ 5600 22000];
    firewall.allowedUDPPorts = [ 22000 ];
  };

  environment.systemPackages = with pkgs; [
    btop
    fishPlugins.tide
    git
    gping
    micro
    neofetch
    neovim
  ];

  system.stateVersion = "23.11";
}
