{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.git;
in 

{
  options.modules.git = { enable = mkEnableOption "git"; };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "dongsu8142";
      userEmail = "dongsu8142@naver.com";
      extraConfig = {
        init = { defaultBranch = "main"; };
      };
    };
    home.packages = with pkgs; [
      lazygit
    ];
  };
}
