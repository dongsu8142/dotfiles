{ config, ... }:

{
  nixpkgs.overlays = [
    (final: prev:
      {
        nvchad = prev.callPackage ./nvchad { };
        naver-whale = prev.callPackage ./naver-whale { };
      }
    )
  ];
}
