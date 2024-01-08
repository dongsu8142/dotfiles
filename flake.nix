{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.34.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gBar = {
      url = "github:scorpion-26/gBar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    dongsu8142-nur.url = "github:dongsu8142/nur";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      user = "hands8142";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      mkSystem = hostname:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            inputs.hyprland.nixosModules.default
            ./overlays
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = {
                  imports = [
                    (import ./hosts/${hostname}/home.nix)
                  ] ++ [
                    inputs.hyprland.homeManagerModules.default
                  ];
                };
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        desktop = mkSystem "desktop";
        server = mkSystem "server";
      };
    };
}
