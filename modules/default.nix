{ pkgs, config, ... }:

{
  imports = [
    ./hyprland
    ./eww
    ./nvim
    ./git
  ];
}
