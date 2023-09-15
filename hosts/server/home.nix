{ config, pkgs, lib, ... }:

{
  imports = 
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/devlop);
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      nodejs_20
      ffmpeg_6
      gcc13
      rustc
      cargo
      screen
      btop
      gnumake
    ];
  };
}
