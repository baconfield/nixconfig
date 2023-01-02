
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
    loader.systemd-boot.configurationLimit = 4;
    loader.efi.canTouchEfiVariables = true;
  };

  age.secrets = {
    publicKeys.file = /root/secrets/publicKeys.age;
  };

  networking = {
    hostName = "RaccoonRapids";
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 5600 ];
    firewall.allowedUDPPorts = [];
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    ports = [ 5600 ];
  };

  environment.systemPackages = with pkgs; [
    btop
    git
    micro
    neofetch
    (callPackage "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/pkgs/agenix.nix" {})
  ];

  time.timeZone = "America/Central";

  users.users.tjcater = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTJTJ8rSJhyCBbev272hIq1JyD22OF5kOheBVo6z6OC tjcater@FoxSummit"
  };

  system = {
    stateVersion = "22.11";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true; # Need to look into upgrade notifications
  };
}
