{ config, pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.editor = false; # Hardening
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.firewall.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    ports = [ 5600 ];
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true; # Need to look into upgrade notifications
    flake = "github:baconfield/nixconfig";
    flags = [
      "--update-input" "nixpkgs"
    ];
  };

  time.timeZone = "America/Central";

  programs.fish.enable = true;

  users.users.tjcater = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTJTJ8rSJhyCBbev272hIq1JyD22OF5kOheBVo6z6OC"
    ];
  };
}
