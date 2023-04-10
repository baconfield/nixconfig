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

  containers.nextcloud = {
    autoStart = true;
    bindMounts."/filepit/nextcloud" = {
      hostPath = "/filepit/nextcloud";
      isReadOnly = false;
    };
    config = { config, pkgs, ... }: {
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud26;
        hostName = "cloud.tortisecove.xyz";
        https = true;
        caching.redis = true;
        caching.apcu = false;
        extraOptions = {
          redis = {
            host = "/run/redis-nextcloud/redis.sock";
            port = 0;
          };
          memcache = {
            local = "\\OC\\Memcache\\Redis";
            distributed = "\\OC\\Memcache\\Redis";
            locking = "\\OC\\Memcache\\Redis";
          };
        };
      };
      services.redis.servers.nextcloud = {
        enable = true;
        user = "nextcloud";
        port = 0;
      };
      networking.firewall.enable = true;
      system.stateVersion = "22.11";
    };
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
    git
    micro
    neofetch
  ];

  system.stateVersion = "21.11";
}
