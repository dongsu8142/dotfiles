{ ... }:
let
  home = {
    username = "hands8142";
    homeDirectory = "/home/hands8142";
    stateVersion = "25.11";
  };
in
{
  home = home;

  imports = [
    ../../dots/nushell
    ../../dots/nvim
  ];

  programs.home-manager.enable = true;
}
