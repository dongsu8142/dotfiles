{ pkgs, lib, config, ... }:

{
  xdg.configFile."git/.gitmessage.txt" = {
    source = ./.gitmessage.txt;
  };
  programs = {
    git = {
      enable = true;
      userName = "dongsu8142";
      userEmail = "dongsu8142@naver.com";
      extraConfig = {
        init = { defaultBranch = "main"; };
        commit = { template = "~/.config/git/.gitmessage.txt"; };
      };
    };
    lazygit = {
      enable = true;
    };
  };
}
