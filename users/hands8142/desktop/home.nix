{ config, pkgs, lib, ... }:

{
  imports = [ ../../../modules ];
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      firefox
      nodejs_20
      ffmpeg_6
      gcc13
      rustc
      cargo
    ];
  };

  modules = {
    hyprland.enable = true;
    nvim.enable = true;
    git.enable = true;
  };
}
