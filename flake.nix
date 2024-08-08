{
  inputs = {
    agenix.url = "github:ryantm/agenix";
  };
  outputs = { self, nixpkgs, agenix, ... }: {
    nixosConfigurations.DoveTrail = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./systems/DoveTrail/DoveTrail.nix
        agenix.nixosModules.default
      ];
    };
    nixosConfigurations.RaccoonRapids = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./systems/RaccoonRapids/RaccoonRapids.nix
        agenix.nixosModules.default
      ];
    };
    nixosConfigurations.TortiseCove = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./systems/TortiseCove/TortiseCove.nix
        agenix.nixosModules.default
      ];
    };
  };
}
