{ config, pkgs, lib, ... }:

{
  imports = 
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs/common) ++
    (import ../../modules/theme/catppuccin/common) ++
    (import ../../modules/devlop);
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      firefox
      discord
      gcc13
      gnumake
      trunk
      terminator
    ];
  };
}
