{ config, lib, pkgs, ... }:

{
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
