{ inputs, lib, config, pkgs, ... }:

with lib;

let
  cfg = config.modules.wezterm;
in

{
  options.modules.wezterm = { enable = mkEnableOption "wezterm"; };
  config = mkIf cfg.enable {
    home = {
      file = {
        ".config/wezterm".source = ./config;
      };
      packages = with pkgs; [
        wezterm
      ];
    };
  };
}
