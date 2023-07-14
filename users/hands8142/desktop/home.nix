{ config, pkgs, lib, ... }:

{
  imports = [ ../../../modules ];
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      firefox
      playerctl
      discord
      postman
      nodejs_20
      gcc13
      rustc
      cargo
      clippy
    ];
  };

  modules = {
    hyprland.enable = true;
    nvim.enable = true;
    git.enable = true;
    kitty.enable = true;
  };
}
