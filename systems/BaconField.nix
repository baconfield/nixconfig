 { config, pkgs, ... }:

{
  networking = {
    hostName = "BaconField";
    firewall.allowedTCPPorts = [ 80 443 ];
  };

  age.secrets.nextcloudPass = {
    file = "/etc/nixos/secrets/nextcloudPass.age";
    owner = "nextcloud";
    group = "nextcloud";
  };

  services = {
    nginx.virtualHosts."cloud.baconfield.xyz" = {
      enableACME = true;
      forceSSL = true;
    };

    nextcloud = {
      hostName = "cloud.tortisecove.xyz";
      config.adminpassFile = config.age.secrets.nextcloudPass.path;
    };
  };

  environment.systemPackages = with pkgs; [
    btop
    git
    micro
  ];

  system.stateVersion = "22.11";
}
