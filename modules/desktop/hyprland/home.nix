{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/hypr-variables.nix)
  ];
  # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  home = {
    file.".config/hypr/config".source = ./config;
    packages = with pkgs; [
      wl-clipboard
    ];
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
      source=~/.config/hypr/config/monitors.conf
      source=~/.config/hypr/config/settings.conf
      source=~/.config/hypr/config/rules.conf
      source=~/.config/hypr/config/binds.conf
      source=~/.config/hypr/config/theme.conf
      source=~/.config/hypr/config/startup.conf
    '';
  };
}
