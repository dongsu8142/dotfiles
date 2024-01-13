{ config, lib, pkgs, ... }:

{
  sound.enable = true;
  services = {
    pipewire = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      pamixer
    ];
  };
}
