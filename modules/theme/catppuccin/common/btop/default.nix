{ pkgs, ... }:

{
  home.file.".config/btop/themes/catppuccin_mocha.theme".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/btop/main/themes/catppuccin_mocha.theme";
    hash = "sha256-TeaxAadm04h4c55aXYUdzHtFc7pb12e0wQmCjSymuug=";
  };

  programs.btop = {
    settings = {
        color_theme = "catppuccin_mocha";
        theme_background = false;
    };
  };
}
