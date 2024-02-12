{ config, lib, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "appmenu-is-back@fthx"
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "monitor@astraext.github.io"
      ];
    };
  };
  home = {
    packages = with pkgs; [
      xclip
      gnomeExtensions.blur-my-shell
      gnomeExtensions.app-menu-is-back
      gnomeExtensions.dash-to-dock
      gnomeExtensions.appindicator
      gnomeExtensions.astra-monitor
    ];
  };
}
