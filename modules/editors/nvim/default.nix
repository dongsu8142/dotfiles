{ config, lib, inputs, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      # withPython3 = true;
      withNodeJs = true;
    };
  };
  home = {
    packages = with pkgs; [
      lua-language-server
      nodePackages.typescript-language-server
    ];
  };
  xdg.configFile."nvim" = {
    source = "${pkgs.nvchad}";
    recursive = true;
  };
}
