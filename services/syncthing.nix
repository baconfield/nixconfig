{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;

    settings.devices = {
      "DoveTrail"     = { id = "RSSLIGN-J6CDKVB-XRL3I4Z-C74QBSK-FHV4OY2-C2MZ575-VGHCQUF-NEZ55Q5"; };
      "FoxSummit"     = { id = "23UFPLY-ATX7XAE-ODKE76T-IGF76JG-P5IGCGY-MJHAXRN-MTGOZGO-NY5HJAS"; };
      "HydraValley"   = { id = "NQJ2CCZ-AAOQGNQ-4FRIROR-HHNXKKX-46KQCT3-NKVSZTR-QJCSVLV-WQLSIAC"; };
      "RaccoonRapids" = { id = "7ZHZ2F2-E4T3VPW-KQROBZT-MTPX2O6-KNXOYFJ-NZYQHHV-JVZNLVA-LZQBFQY"; };
    };
    settings.folders =
      let devices = [
        "DoveTrail"
        "FoxSummit"
        "RaccoonRapids"
      ];
      in {
        "Documents" = {
          id = "oc4g6-xbnpq";
          path = "/Filepit/Documents";
          devices = devices;
        };
        "Music" = {
          id = "yinnq-rva4h";
          path = "/Filepit/Music";
          devices = devices;
        };
        "Pictures" = {
          id = "xcrth-tep2j";
          path = "/Filepit/Pictures";
          devices = devices;
        };
        "Music Videos" = {
          id = "tm4hc-ge4yd";
          path = "/Filepit/Music\ Videos";
          devices = devices;
        };
        "Videos" = {
          id = "5cwgs-v3tih";
          path = "/Filepit/Videos";
          devices = devices;
        };
      };
  };
}
