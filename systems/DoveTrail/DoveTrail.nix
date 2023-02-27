{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "DoveTrail";
    firewall.allowedTCPPorts = [ 853 3000 5600 6700 ];
    firewall.allowedUDPPorts = [ 53 ];
  };

  containers.adguardhome = {
    autoStart = true;
    config = { config, pkgs, ... }: {
      services.adguardhome.enable = true;
      services.adguardhome.mutableSettings = true;
      services.adguardhome.settings = true;
      services.adguardhome.openFirewall = true;
      networking.firewall.enable = true;
      system.stateVersion = "22.11";
    };
  };

  containers.uptime-kuma = {
    autoStart = true;
    config = { config, pkgs, ... }: {
      services.uptime-kuma.enable = true;
      services.uptime-kuma.settings = { PORT =  "6700"; };
      networking.firewall.enable = true;
      system.stateVersion = "22.11";
      environment.etc."resolv.conf".text = "nameserver 8.8.8.8";
    };
  };

  systemd.services.container@uptime-kuma.Unit.After = "network.target";

  environment.systemPackages = with pkgs; [
    btop
    git
    micro
    neofetch
  ];

  system.stateVersion = "22.11";
}
