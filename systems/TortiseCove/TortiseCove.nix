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
    firewall.allowedTCPPorts = [ 5600 6443 8096 8384 8920 22000 ];
    firewall.allowedUDPPorts = [ 1900 7359 22000 ];
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

  virtualisation.containerd = {
    enable = true;
    settings =
      let
        fullCNIPlugins = pkgs.buildEnv {
          name = "full-cni";
          paths = with pkgs;[
            cni-plugins
            cni-plugin-flannel
          ];
        };
      in {
        plugins."io.containerd.grpc.v1.cri".cni = {
          bin_dir = "${fullCNIPlugins}/bin";
          conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
        };
      };
  };

  services.k3s = { # Uses port 6443
    enable = true;
    role = "server";
    extraFlags = toString [
      "--write-kubeconfig-mode --container-runtime-endpoint unix:///run/containerd/containerd.sock"
    ];
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
    k3s
    micro
    neofetch
  ];

  system.stateVersion = "21.11";
}
