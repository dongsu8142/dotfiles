{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.ags;
in 

{
  options.modules.ags = { enable = mkEnableOption "ags"; };
  config = mkIf cfg.enable {
    home = {
      file.".config/ags".source = ./ags;
      packages = with pkgs; [
        ags
        socat
      ];
    };
  };
}
