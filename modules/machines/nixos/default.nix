{ lib, self, ... }:
let
  entries = builtins.attrNames (builtins.readDir ./.);
  configs = builtins.filter
    (dir: builtins.pathExists (./. + "/${dir}/configuration.nix")) entries;
  homeManagerCfg = userPackages: extraImports: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = userPackages;
      users.hands8142.imports = [ ../../../home.nix ../../users/hands8142/dots.nix ] ++ extraImports;
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
        self.inputs.disko.nixosModules.disko
        self.inputs.home-manager.nixosModules.home-manager
        ../../homelab
        ../../hardware
        ../../desktop
        ../../users/hands8142
        (./. + "/_common/default.nix")
        (./. + "/${name}/configuration.nix")
        (homeManagerCfg true [ ])
      ];
    })) configs);
}
