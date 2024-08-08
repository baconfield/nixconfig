{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  age.secrets = {
    publicKeys.file = /root/secrets/publicKeys.age;
  };

  networking = {
    hostName = "RaccoonRapids";
    firewall.allowedTCPPorts = [ 5600 ];
    firewall.allowedUDPPorts = [];
  };

  environment.systemPackages = with pkgs; [
    btop
    git
    micro
    neofetch
  ];

  system.stateVersion = "22.11";
}
