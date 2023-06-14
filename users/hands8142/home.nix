{ config, pkgs, lib, ... }:

{
  imports = [ ../../modules ];
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      nodejs_20
      ffmpeg_6
    ];
  };

  programs.git = {
    enable = true;
    userName = "dongsu8142";
    userEmail = "dongsu8142@naver.com";
  };
}
