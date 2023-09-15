{ config, lib, pkgs, inputs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      enableNvidiaPatches = true;
    };
  };
}
