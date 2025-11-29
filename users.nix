{ config, pkgs, ... }:

{
  programs.fish.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryPackage = pkgs.pinentry-curses;
     enableSSHSupport = true;
  };

  users.users.tjcater = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/BT/Zu+Z5PnNZ4se659w6Hum4thYwHvwpiT4FMU92s"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4KEp5ORzN6Wiswlv8Zz8yRTXYck2kwC3XbJjKXdnaD"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQPYju8i0mzTFXqcllhgL8vbxcQoRbEOdmlf0iIz2zE"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+0mVPjaSeqeeA67HCj1jSUt744SdYYEjCI7L+lOmQf"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFOOCwlKJtl8UNzPuZqip0ptI0d496HwtYox0T+DYOW"
    ];
  };
}
