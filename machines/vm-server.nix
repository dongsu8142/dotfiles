{ config, pkgs, ... }:

{
  imports = 
  [
    ./shared.nix
    ../hardware/vm.nix
  ];
}
