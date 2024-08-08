 
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.editor = false; # Hardening
    loader.systemd-boot.configurationLimit = 15;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "DoveTrail";
    firewall.enable = true;
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

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    ports = [ 5600 ];
  };
  systemd.services.container@uptime-kuma.Unit.After = "network.target";

  environment.systemPackages = with pkgs; [
    btop
    git
    micro
    neofetch
  ];

  time.timeZone = "America/Central";

  users.users.tjcater = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      [REDACTED]
    ];
  };

  system = {
    stateVersion = "22.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true; # Need to look into upgrade notifications
  };
}
