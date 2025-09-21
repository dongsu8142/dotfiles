{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/dongsu8142/secrets.git";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, home-manager, sops-nix, rust-overlay, ... }@inputs: {
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          { nixpkgs.overlays = [ rust-overlay.overlays.default ]; }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.hands8142.imports = [ ./home.nix ];
              extraSpecialArgs = { inherit inputs; };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };

}
