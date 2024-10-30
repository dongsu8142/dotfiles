{ config, lib, pkgs, inputs, ... }:
{
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit # text editor
  ]) ++ (with pkgs; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
  ]);
  programs.dconf.enable = true;
  environment = {
    variables = {
      GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0"; # astra monitor
    };
    systemPackages = with pkgs; [
      gnome-tweaks
      libgtop # astra monitor
    ];
  };
}
