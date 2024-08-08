{ config, pkgs, ... }:

{
  boot = {
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
    kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;
  };

  networking = {
    hostName = "TortiseCove";
    hostId = "f55e9dd6"; # Just needs to be unique from other machines on the network
    firewall.allowedTCPPorts = [ 80 443 5600 6443 8384 22000 ];
    firewall.allowedUDPPorts = [ 22000 ];
    bonds.bond0 = {
      interfaces = [
        "enp8s0f0"
        "enp8s0f1"
      ];
      driverOptions.mode = "active-backup";
      driverOptions.miimon = "100";
    };
  };

  age.secrets.credentials.file = "/etc/nixos/secrets/credentials.age";
  age.secrets.nextcloudPass = {
    file = "/etc/nixos/secrets/nextcloudPass.age";
    owner = "nextcloud";
    group = "nextcloud";
  };

  security.acme = {
    defaults = {
      dnsProvider = "cloudflare";
      credentialsFile = config.age.secrets.credentials.path;
    };
    certs."tortisecove.xyz" = {
      domain  = "*.tortisecove.xyz";
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

  services = {
    nginx.virtualHosts."jellyfin.tortisecove.xyz" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
    };

    nginx.virtualHosts."cloud.tortisecove.xyz" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
    };

    nextcloud = {
      hostName = "cloud.tortisecove.xyz";
      config.adminpassFile = config.age.secrets.nextcloudPass.path;
    };

    syncthing = { # Uses ports 8384 and 22000
      user = "tjcater";
      configDir = "/home/tjcater/.config/syncthing";
      guiAddress = "10.0.1.100:8384";
    };

    udev.extraRules = ''
        ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
      '';

    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
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
