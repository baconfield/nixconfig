{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/filepit";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "BaconField"  = { id = "W4FMJ4K-Q3L27RM-MFWKF5E-MNS7535-JX7K2A4-YLW7TBP-B2DOABF-KI7XKQO"; };
      "DoveTrail"   = { id = "CPJONFR-X2T7UDY-WOZGTVH-UMXFYKA-CHPLB5K-N2VNQJP-PF6NQLX-6AMN3AZ"; };
      "FoxSummit"   = { id = "L435IMJ-BE77VDL-VAJUQHG-PDIZHOP-DAT2DUE-4SKXJLS-G2UEOHP-L5NXIQ2"; };
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
