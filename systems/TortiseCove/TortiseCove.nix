{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/modules/age.nix"
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.editor = false; # Hardening
    loader.systemd-boot.configurationLimit = 15;
    loader.efi.canTouchEfiVariables = true;
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
  };

  networking = {
    hostName = "TortiseCove";
    hostId = "f55e9dd6"; # Just needs to be unique from other machines on the network
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 5600 8096 8384 8920 22000 ];
    firewall.allowedUDPPorts = [ 1900 7359 22000 21027 ];
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
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
      ports = [ 5600 ];
    };
    syncthing = { # Uses ports 8384, 22000, and 21027
      enable = true;
      user = "tjcater";
      dataDir = "/filepit"; # Default folder for newly synced folders
      configDir = "/home/tjcater/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
      devices = {
        "FoxSummit" = { id = "[REDACTED]"; };
        "DoveTrail" = { id = "[REDACTED]"; }; # Need to replace id once reestablished
      };
      folders = {
        "Documents" = {
          id = "[REDACTED]";
          path = "/filepit/documents";
          devices = [ "FoxSummit" "DoveTrail" ];
        };
        "Music" = {
          id = "[REDACTED]";
          path = "/filepit/music";
          devices = [ "FoxSummit" "DoveTrail" ];
        };
        "Pictures" = {
          id = "[REDACTED]";
          path = "/filepit/pictures";
          devices = [ "FoxSummit" "DoveTrail" ];
        };
        "Videos" = {
          id = "[REDACTED]";
          path = "/filepit/videos";
          devices = [ "FoxSummit" "DoveTrail" ];
        };
      };

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
      "[REDACTED]"
    ];
  };

  system = {
    stateVersion = "21.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true; # Need to look into upgrade notifications
  };
}
