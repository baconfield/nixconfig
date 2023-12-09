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

  time.timeZone = "America/Chicago";

  programs.fish.enable = true;

  users.groups.multimedia = { };

  users.users.tjcater = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTJTJ8rSJhyCBbev272hIq1JyD22OF5kOheBVo6z6OC"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/BT/Zu+Z5PnNZ4se659w6Hum4thYwHvwpiT4FMU92s"
    ];
  };
}
