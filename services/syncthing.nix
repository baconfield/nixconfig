{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/filepit";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "BaconField"  = { id = "W4FMJ4K-Q3L27RM-MFWKF5E-MNS7535-JX7K2A4-YLW7TBP-B2DOABF-KI7XKQO"; };
      "DoveTrail"   = { id = "NG6KOPP-PYDRCEF-GTBNXQF-AXDW4HI-A7BEWYD-PUP5SOO-V3XA5SW-NWDSWQA"; };
      "FoxSummit"   = { id = "23UFPLY-ATX7XAE-ODKE76T-IGF76JG-P5IGCGY-MJHAXRN-MTGOZGO-NY5HJAS"; };
      "TanukiGrove" = { id = "O4BHV2P-R426POT-HVUM53Z-FKEFJTP-JFO4635-YYVRACN-SWLKFUN-JVAR3QI"; };
      "TortiseCove" = { id = "6F6NVYV-2TGSVKK-YQF52M6-FVHESYJ-4GD3FL5-MBYGOPL-HSQVPZH-ULVMUQM"; };
    };
    folders =
      let devices = [
        "BaconField"
        "FoxSummit"
        "TanukiGrove"
        "TortiseCove"
        "TanukiGrove"
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
