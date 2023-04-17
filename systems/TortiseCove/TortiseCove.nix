{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
  };

  networking = {
    hostName = "TortiseCove";
    hostId = "f55e9dd6"; # Just needs to be unique from other machines on the network
    firewall.allowedTCPPorts = [ 80 443 5600 6443 8384 22000 ];
    firewall.allowedUDPPorts = [ 22000 ];
  };

  age.secrets = {
    credentials.file = "/etc/nixos/secrets/credentials.age";
    nextcloudPass = {
      file = "/etc/nixos/secrets/nextcloudPass.age";
      owner = "nextcloud";
      group = "nextcloud";
    };
  };

  security.acme= {
    defaults = {
      dnsProvider = "cloudflare";
      credentialsFile = config.age.secrets.credentials.path;
    };
    certs."tortisecove.xyz" = {
      domain  = "*.tortisecove.xyz";
    };
  };

  services.nginx.virtualHosts = {
    "jellyfin.tortisecove.xyz" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
    };
    "cloud.tortisecove.xyz" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
    };
  };

  containers.jellyfin = { # Uses ports 1900, 7359, 8096, and 8920
    autoStart = true;
    bindMounts = {
      "/filepit/music" = { hostPath = "/filepit/music"; };
      "/filepit/videos" = { hostPath = "/filepit/videos"; };
    };
    config = { config, pkgs, ... }: {
      services.jellyfin.enable = true;
      services.jellyfin.openFirewall = true;
      networking.firewall.enable = true;
      system.stateVersion = "22.05";
    };
  };

  services.nextcloud = {
    hostName = "cloud.tortisecove.xyz";
    config.adminpassFile = config.age.secrets.nextcloudPass.path;
  };

  services.syncthing = { # Uses ports 8384 and 22000
    user = "tjcater";
    configDir = "/home/tjcater/.config/syncthing";
    guiAddress = "10.0.1.100:8384";
  };

  services.udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
    '';

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  environment.systemPackages = with pkgs; [
    btop
    fishPlugins.tide
    git
    gping
    micro
    neofetch
  ];

  system.stateVersion = "21.11";
}
