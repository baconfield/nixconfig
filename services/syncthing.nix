{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/filepit";
    overrideDevices = true;
    overrideFolders = true;
    folders = {
      "Documents" = {
        id = "oc4g6-xbnpq";
        path = "/filepit/documents";
      };
      "Music" = {
        id = "yinnq-rva4h";
        path = "/filepit/music";
      };
      "Pictures" = {
        id = "xcrth-tep2j";
        path = "/filepit/pictures";
      };
      "Videos" = {
        id = "5cwgs-v3tih";
        path = "/filepit/videos";
      };
    };
  };
}
