{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ gcc gh lazygit ];
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
