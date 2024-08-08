{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/filepit";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "DoveTrail"   = { id = "RSSLIGN-J6CDKVB-XRL3I4Z-C74QBSK-FHV4OY2-C2MZ575-VGHCQUF-NEZ55Q5"; };
      "FoxSummit"   = { id = "23UFPLY-ATX7XAE-ODKE76T-IGF76JG-P5IGCGY-MJHAXRN-MTGOZGO-NY5HJAS"; };
    };
    folders =
      let devices = [
        "DoveTrail"
        "FoxSummit"
      ];
      in {
        "Documents" = {
          id = "oc4g6-xbnpq";
          path = "/filepit/documents";
          devices = devices;
        };
        "Music" = {
          id = "yinnq-rva4h";
          path = "/filepit/music";
          devices = devices;
        };
        "Pictures" = {
          id = "xcrth-tep2j";
          path = "/filepit/pictures";
          devices = devices;
        };
        "Videos" = {
          id = "5cwgs-v3tih";
          path = "/filepit/videos";
          devices = devices;
        };
      };
  };
}
