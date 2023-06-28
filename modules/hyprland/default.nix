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
    home.file. ".local/bin/hypr" = {
      executable = true;
      text = ''
      #!/bin/sh
        export WLR_NO_HARDWARE_CURSORS=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
          PATH="$HOME/.local/bin:$HOME/bin:$PATH"; fi

        if ! [[ "$PATH" =~ "$HOME/.nix-profile/bin:" ]]; then
          PATH="$HOME/.nix-profile/bin:$PATH"; fi

        export PATH
        exec nixGL ${pkgs.hyprland}/bin/Hyprland
      '';
    };
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
      nvidiaPatches = true;
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
