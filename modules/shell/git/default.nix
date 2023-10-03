{ pkgs, lib, config, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "dongsu8142";
      userEmail = "dongsu8142@naver.com";
      extraConfig = {
        init = { defaultBranch = "main"; };
      };
    };
    lazygit = {
      enable = true;
    };
  };
}
