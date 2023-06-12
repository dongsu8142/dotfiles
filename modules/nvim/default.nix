{ lib, config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # extraConfig = pkgs.lib.fileContents ../../nvim/init.lua;
  };
}
