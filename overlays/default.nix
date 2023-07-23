{ config, inputs, ... }:

{
  nixpkgs.overlays = [
    (final: prev:
      {
        nur = import inputs.nur {
          nurpkgs = prev;
          pkgs = prev;
          repoOverrides = {
            dongsu8142 = inputs.dongsu8142-nur.packages.${prev.system};
          };
        };
        nvchad = prev.callPackage ./nvchad { };
      }
    )
  ];
}
