{ config, lib, pkgs, ... }:

{
  programs = {
    java = {
      enable = true;
      package = pkgs.openjdk17;
    };
  };
  home = {
    packages = with pkgs; [
      (maven.override {
        jdk = openjdk17;
       })
      (gradle.override {
        java = openjdk17;
      })
    ];
  };
}
