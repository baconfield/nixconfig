{
  inputs.agenix = {
    url = "github:ryantm/agenix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.darwin.follows = "";
  };
  outputs = { self, nixpkgs, agenix, ... }: {
    nixosConfigurations.DoveTrail = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/syncthing.nix
        ./systems/DoveTrail/DoveTrail.nix
        agenix.nixosModules.default
      ];
    };
    nixosConfigurations.RaccoonRapids = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./systems/RaccoonRapids/RaccoonRapids.nix
        agenix.nixosModules.default
      ];
    };
    nixosConfigurations.TanukiGrove = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/syncthing.nix
        ./systems/TanukiGrove/TanukiGrove.nix
        agenix.nixosModules.default
      ];
    };
    nixosConfigurations.TortiseCove = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/nginx.nix
        ./services/syncthing.nix
        ./systems/TortiseCove/TortiseCove.nix
        agenix.nixosModules.default
      ];
    };
  };
}
