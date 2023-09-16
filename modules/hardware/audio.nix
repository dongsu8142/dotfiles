{ config, lib, pkgs, ... }:

{
  sound.enable = true;
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      pamixer
    ];
  };
}
