{ config, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  networking.firewall.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
    ports = [ 5600 ];
  };

  services.tailscale.enable = true;
  services.tailscale.interfaceName = "userspace-networking";

  time.timeZone = "America/Chicago";

  programs.fish.enable = true;
  
  users.users.tjcater = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE6PkhvCO2rO0CXuszoknbAyKcxZ2ucBz2KHP6l2I3l3"
    ];
  };
}
