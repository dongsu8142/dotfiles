{ config, pkgs, lib, ... }:

{
  imports = 
    [ (import ../../modules/desktop/hyprland/home.nix) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs/wayland) ++
    (import ../../modules/theme/catppuccin/common) ++
    (import ../../modules/devlop);
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      nur.repos.dongsu8142.naver-whale
      playerctl
      (writeShellApplication {
      name = "discord";
        text = "${discord}/bin/discord --use-gl=desktop";
      })
      (makeDesktopItem {
        name = "discord";
        exec = "discord";
        desktopName = "Discord";
      })
      postman
      nodejs_20
      gcc13
      btop
      gnumake
    ];
  };
}
