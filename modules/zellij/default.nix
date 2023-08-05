{ inputs, lib, config, pkgs, ... }:

with lib;

let
  cfg = config.modules.zellij;
in

{
  options.modules.zellij = { enable = mkEnableOption "zellij"; };
  config = mkIf cfg.enable {
    home = {
      file = {
        ".config/zellij".source = ./config;
      };
      packages = with pkgs; [
        zellij
      ];
    };
  };
}
