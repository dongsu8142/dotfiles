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
    home.packages = with pkgs; [
      lua-language-server
      nodePackages.typescript-language-server
      rust-analyzer
      rustfmt
    ];
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
