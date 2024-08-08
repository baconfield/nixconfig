{ config, pkgs, ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "baconfield@protonmail.com";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
}
