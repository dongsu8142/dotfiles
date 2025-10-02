{ lib, pkgs, config, ... }:
{
  options.desktop = {
    enable = lib.mkEnableOption "Desktop";
  };

  config = lib.mkIf config.desktop.enable {
    fonts.packages = with pkgs; [
      noto-fonts-cjk-sans
      nanum
      nerd-fonts.fira-code
    ];

    environment.systemPackages = with pkgs; [
      firefox
      ghostty
      neovide
    ];
  };

  imports = [
    ./cosmic
  ];
}
