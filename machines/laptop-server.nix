{ config, pkgs, ... }:

{
  imports = 
  [
    ./shared.nix
    ../hardware/laptop.nix
  ];
}
