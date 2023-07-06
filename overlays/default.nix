{ config, ... }:

{
  nixpkgs.overlays = [
    (final: prev:
      {
        nvchad = prev.callPackage ./nvchad { };
      }
    )
  ];
}
