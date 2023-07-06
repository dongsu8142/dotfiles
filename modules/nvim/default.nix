{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.modules.nvim;
in

{
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    xdg.configFile."nvim" = {
      source = "${pkgs.nvchad}";
      recursive = true;
    };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
