{ config, lib, inputs, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      viAlias = true;
      vimAlias = true;
      # withPython3 = true;
      withNodeJs = true;
      defaultEditor = true;
    };
  };
  home = {
    packages = with pkgs; [
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.prettier
      nodePackages.eslint
    ];
  };
  xdg.configFile."nvim" = {
    # source = "${pkgs.nvchad}";
    source = ./config;
    recursive = true;
  };
}
