{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      (python312.override { x11Support = true; })
    ];
  };
}
