{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nodejs_21
      yarn
    ];
  };
}
