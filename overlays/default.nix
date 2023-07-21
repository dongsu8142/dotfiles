{ config, ... }:

{
  nixpkgs.overlays = [
    (final: prev:
      {
        nvchad = prev.callPackage ./nvchad { };
        naver-whale-stable = prev.callPackage ./naver-whale-stable { };
      }
    )
  ];
}
