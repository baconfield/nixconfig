{
  inputs.agenix = {
    url = "github:ryantm/agenix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.darwin.follows = "";
  };
  outputs = { self, nixpkgs, agenix, ... }: {
    nixosConfigurations.BaconField = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/nginx.nix
        ./services/nextcloud.nix
        ./systems/BaconField.nix
        ./hardware/BaconField.nix
      ];
    };
    nixosConfigurations.DoveTrail = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/syncthing.nix
        ./systems/DoveTrail.nix
        ./hardware/DoveTrail.nix
      ];
    };
    nixosConfigurations.RaccoonRapids = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./systems/RaccoonRapids.nix
        ./hardware/RaccoonRapids.nix
      ];
    };
    nixosConfigurations.TanukiGrove = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/syncthing.nix
        ./systems/TanukiGrove.nix
        ./hardware/TanukiGrove.nix
      ];
    };
    nixosConfigurations.TortiseCove = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/nextcloud.nix
        ./services/nginx.nix
        ./services/syncthing.nix
        ./systems/TortiseCove.nix
        ./hardware/TortiseCove.nix
        agenix.nixosModules.default
      ];
    };
  };
}
