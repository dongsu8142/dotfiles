{ inputs, lib, config, ... }:

with lib;

let
  cfg = config.modules.eww;
in

{
  options.modules.eww = { enable = mkEnableOption "eww"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eww-wayland
    ];
    home.file.".config/eww".source = ./eww;
  };
}
