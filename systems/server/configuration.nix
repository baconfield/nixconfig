{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
  };

  networking = {
    hostName = "TortiseCove";
    hostId = "f55e9dd6"; # Just needs to be unique from other machines on the network
    useDHCP = false;
    interfaces.enp1s0.useDHCP = true;
    interfaces.enp5s0.useDHCP = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 5600 8384 22000 ];
    firewall.allowedUDPPorts = [ 22000 21027 ];
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
      ports = [ 5600 ];
    };
    syncthing = {
      enable = true;
      user = "tjcater";
      dataDir = "/filepit"; # Default folder for newly synced folders
      configDir = "/home/tjcater/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
      devices = {
        "FoxSummit" = { id = "[REDACTED]"; };
        "DoveTrail" = { id = "[REDACTED]"; };
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
          id = "[REDACTED]m";
          path = "/filepit/videos";
          devices = [ "FoxSummit" "DoveTrail" ];
        };
      };

    };
    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
    '';
  };

  environment.systemPackages = with pkgs; [
    btop
    fish
    git
    micro
    neofetch
    syncthing
  ];

  time.timeZone = "America/Central";

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.tjcater = {
     isNormalUser = true;
     shell = pkgs.fish;
     home = "/home/tjcater";
     extraGroups = [ "wheel" ];
     initialHashedPassword = "bacon"; # Didn't actually do anything?
  };

  system = {
    stateVersion = "21.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;

  };
}
