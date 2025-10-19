{
  config,
  lib,
  ...
}: let
  hl = config.homelab;
  cfg = hl.services.qbittorrent;
in {
  options.homelab.services.qbittorrent = {
    enable = lib.mkEnableOption "Qbittorrent torrent client";
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/qbittorrent";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "qbt.${hl.baseDomain}";
    };
    homepage.name = lib.mkOption {
      type = lib.types.str;
      default = "Qbittorrent";
    };
    homepage.description = lib.mkOption {
      type = lib.types.str;
      default = "Torrent client";
    };
    homepage.icon = lib.mkOption {
      type = lib.types.str;
      default = "qbittorrent.svg";
    };
    homepage.category = lib.mkOption {
      type = lib.types.str;
      default = "Downloads";
    };
  };
  config = lib.mkIf cfg.enable {
    services.qbittorrent = {
      enable = true;
      user = hl.user;
      group = hl.group;
    };

    services.caddy.virtualHosts."${cfg.url}" = {
      useACMEHost = hl.baseDomain;
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8080
      '';
    };
  };
}
