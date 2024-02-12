{ pkgs, ... }:

let
  theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/starship/main/palettes/mocha.toml";
    hash = "sha256-cSaZrSfbk97d2kV3q5dT924MgmUuY8eYIIU0PIygH5w=";
  };
in

{
  programs.starship = {
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };
      aws = {
        symbol = "🅰 ";
      };
      gcloud = {
        format = "on [$symbol$active(\($region\))]($style) ";
        symbol = "🅶 ️";
      };
      palette = "catppuccin_mocha";
    }
    // builtins.fromTOML (builtins.readFile "${theme}");
  };
}
