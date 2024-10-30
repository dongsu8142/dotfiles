{ config, pkgs, lib, inputs, ... }:

{
  imports =
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs/desktop) ++
    (import ../../modules/theme/catppuccin/desktop) ++
    (import ../../modules/devlop) ++
    [../../modules/desktop/gnome/home.nix];
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      # firefox
      inputs.dongsu8142-nur.packages."x86_64-linux".naver-whale
      discord
      gcc13
      gnumake
      trunk
      ffmpeg
      jetbrains.rust-rover
      jetbrains.goland
      zed-editor
    ];
  };
  xdg.userDirs = {
    enable = true;
  };
}
