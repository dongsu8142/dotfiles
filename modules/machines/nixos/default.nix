{ lib, self, ... }:
let
  entries = builtins.attrNames (builtins.readDir ./.);
  configs = builtins.filter
    (dir: builtins.pathExists (./. + "/${dir}/configuration.nix")) entries;
  homeManagerCfg = userPackages: extraImports: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = userPackages;
      users.hands8142.imports = [ ../../../home.nix ] ++ extraImports;
      extraSpecialArgs = { inherit (self) inputs; };
      backupFileExtension = "backup";
    };
  };
in {
  flake.nixosConfigurations = lib.listToAttrs (builtins.map (name:
    lib.nameValuePair name (self.inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit (self) inputs; };
      modules = [
        self.inputs.sops-nix.nixosModules.sops
        self.inputs.home-manager.nixosModules.home-manager
        ../../homelab
        (./. + "/_common/default.nix")
        (./. + "/${name}/configuration.nix")
        (homeManagerCfg true [ ])
      ];
    })) configs);
  # server = self.inputs.nixpkgs.lib.nixosSystem {
  #   system = "x86_64-linux";
  #   specialArgs = { inherit (self) inputs; };
  #   modules = [
  #     ../../../configuration.nix
  #     self.inputs.sops-nix.nixosModules.sops
  #     self.inputs.home-manager.nixosModules.home-manager
  #     { nixpkgs.overlays = [ self.inputs.rust-overlay.overlays.default ]; }
  #     {
  #       home-manager = {
  #         useGlobalPkgs = true;
  #         useUserPackages = true;
  #         users.hands8142.imports = [ ../../../home.nix ];
  #         extraSpecialArgs = { inherit (self) inputs; };
  #         backupFileExtension = "backup";
  #       };
  #     }
  #   ];
  # };
}
