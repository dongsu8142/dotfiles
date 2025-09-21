{ config, pkgs, ... }:

{
  home.username = "hands8142";
  home.homeDirectory = "/home/hands8142";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [ gcc gh ];
  programs = {
    git = {
      enable = true;
      userName = "dongsu8142";
      userEmail = "dongsu8142@naver.com";
      extraConfig = { init = { defaultBranch = "main"; }; };
    };
    bash.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };
  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
}
