{ config, pkgs, lib, ... }:

{
  imports = [ ../../../modules ];
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "23.11";
    packages = with pkgs; [
      nodejs_20
      ffmpeg_6
    ];
  };

  modules = {
    nvim.enable = true;
    git.enable = true;
  };
}
