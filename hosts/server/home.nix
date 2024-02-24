{ config, pkgs, lib, ... }:

{
  imports =
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/devlop) ++
    (import ../../modules/theme/catppuccin/common);
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      ffmpeg
      gcc13
      screen
      btop
      gnumake
      trunk
    ];
  };
}
