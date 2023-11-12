{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        set -g theme_nerd_fonts yes
      '';
    };
  };
}
