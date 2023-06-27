{ inputs, lib, config, ... }:

with lib;

let
  cfg = config.modules.hyprland;
in

{
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  imports = [ inputs.hyprland.homeManagerModules.default ];
  config = mkIf cfg.enable {
    home.file.".config/hypr/config".source = ./config;
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        source=~/.config/hypr/config/monitors.conf
        source=~/.config/hypr/config/settings.conf
        source=~/.config/hypr/config/rules.conf
        source=~/.config/hypr/config/binds.conf
        source=~/.config/hypr/config/theme.conf
        source=~/.config/hypr/config/startup.conf
      '';
    };
  };
}
