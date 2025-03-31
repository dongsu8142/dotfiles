{ config, lib, pkgs, ... }:

{
  services = {
    # tlp.enable = true;
    # auto-cpufreq.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
    pulseaudio.support32Bit = true;
  };
  hardware = {
    nvidia = {
      open = false;
      # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        nvidia-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
  environment = {
    systemPackages = with pkgs; [
      libva
      libva-utils
      glxinfo
    ];
  };
}
