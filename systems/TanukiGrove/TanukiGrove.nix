
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "TanukiGrove";
    firewall.allowedTCPPorts = [ 5600 8384 22000 ];
    firewall.allowedUDPPorts = [ 22000 ];
  };

  services.syncthing = {
    guiAddress = "10.0.1.10:8384";
    devices = {
      "BaconField" = { id = "[REDACTED]"; };
      "DoveTrail"   = { id = "[REDACTED]"; };
      "FoxSummit"   = { id = "[REDACTED]"; };
      "TortiseCove" = { id = "[REDACTED]"; };
    };
    folders =
      let devices = [ "BaconField" "DoveTrail" "FoxSummit" "TanukiGrove" ];
      in {
        "Documents".devices = devices;
        "Music".devices = devices;
        "Pictures".devices = devices;
        "Videos".devices = devices;
      };
  };

  system.stateVersion = "22.11";
}
