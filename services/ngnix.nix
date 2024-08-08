{ config, pkgs, ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "baconfield@protonmail.com";
  };

  services.ngnix = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
}
