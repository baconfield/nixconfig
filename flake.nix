{
  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, home-manager, ... }: {
    nixosConfigurations.HydraValley = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./systems/HydraValley.nix
        ./hardware/HydraValley.nix
      ];
    };
    nixosConfigurations.OrcaStrait = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./proxmox.nix
        ./systems/OrcaStrait.nix
      ];
    };
  };
}
