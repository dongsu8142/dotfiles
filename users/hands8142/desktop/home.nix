{ config, pkgs, lib, ... }:

{
  imports = [ ../../../modules ];
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
      podman-compose
      nodejs_20
      gcc13
      rustc
      cargo
      clippy
      cargo-watch
      wl-clipboard
    ];
  };

  modules = {
    hyprland.enable = true;
    nvim.enable = true;
    git.enable = true;
    kitty.enable = true;
    ags.enable = true;
    zellij.enable = true;
    wezterm.enable = true;
    ssh-key.enable = true;
  };
}
