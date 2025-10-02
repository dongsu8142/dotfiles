{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cosmic = {
    enable = lib.mkEnableOption "Cosmic Desktop";
  };

  config = lib.mkIf config.cosmic.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
