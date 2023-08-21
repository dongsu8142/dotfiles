{ pkgs, config, ... }:

{
  imports = [
    ./hyprland
    ./nvim
    ./git
    ./kitty
    ./ags
    ./zellij
    ./wezterm
    ./ssh-key
  ];
}
