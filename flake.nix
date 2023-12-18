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
    kde2nix = {
      url = "github:nix-community/kde2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, agenix, kde2nix, home-manager, ... }: {
    nixosConfigurations.BaconField = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/nginx.nix
        ./services/nextcloud.nix
        ./systems/BaconField.nix
        ./hardware/BaconField.nix
        agenix.nixosModules.default
      ];
    };
    nixosConfigurations.DoveTrail = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./server.nix
        ./services/syncthing.nix
        ./systems/DoveTrail.nix
      ];
    };
    nixosConfigurations.HydraValley = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./desktop.nix
        ./services/syncthing.nix
        ./systems/HydraValley.nix
        ./hardware/HydraValley.nix
      ];
    };
    nixosConfigurations.JellyCoast = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./proxmox.nix
        ./systems/JellyCoast.nix
      ];
    };
    nixosConfigurations.RaccoonRapids = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./proxmox.nix
        ./services/syncthing.nix
        ./systems/RaccoonRapids.nix
      ];
    };
    nixosConfigurations.SalamanderGrotto = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./proxmox.nix
        ./systems/SalamanderGrotto.nix
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
