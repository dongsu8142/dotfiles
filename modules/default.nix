{ pkgs, config, ... }:

{
  imports = [
    ./hyprland
    ./nvim
    ./git
    ./kitty
  ];
}
