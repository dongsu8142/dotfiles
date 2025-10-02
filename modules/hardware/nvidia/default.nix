{
  pkgs,
  lib,
  config,
  ...
}: {
  options.nvidia = {
    enable = lib.mkEnableOption "Nvidia";
  };

  config = lib.mkIf config.nvidia.enable {
    services = {
      xserver.videoDrivers = [ "nvidia" ];
    };
    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
      };
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
