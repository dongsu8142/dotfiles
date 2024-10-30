{ config, lib, pkgs, ... }:

{
  programs = {
    java = {
      enable = true;
      package = pkgs.jdk17;
    };
  };
  home = {
    packages = with pkgs; [
      (maven.override {
        jdk_headless = jdk17;
       })
      (gradle.override {
        java = jdk17;
      })
    ];
  };
}
