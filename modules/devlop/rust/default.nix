{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      rustc
      cargo
      clippy
      cargo-watch
    ];
  };
}
