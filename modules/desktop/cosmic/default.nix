{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.cosmic = {
    enable = lib.mkEnableOption "Cosmic Desktop";
  };

  config = lib.mkIf config.desktop.cosmic.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
