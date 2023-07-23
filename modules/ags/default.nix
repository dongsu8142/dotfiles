{ pkgs, lib, config, inputs, ... }:

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
        inputs.ags.packages.${pkgs.system}.default
        socat
      ];
    };
  };
}
