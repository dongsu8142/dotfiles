{ config, lib, ... }:
let
  service = "freshrss";
  hl = config.homelab;
  cfg = hl.services.${service};
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption { description = "Enable ${service}"; };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/${service}";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "news.${hl.baseDomain}";
    };
    homepage.name = lib.mkOption {
      type = lib.types.str;
      default = "FreshRSS";
    };
    homepage.description = lib.mkOption {
      type = lib.types.str;
      default = "RSS feed aggregator";
    };
    homepage.icon = lib.mkOption {
      type = lib.types.str;
      default = "freshrss.svg";
    };
    homepage.category = lib.mkOption {
      type = lib.types.str;
      default = "Services";
    };
    passwordFile = lib.mkOption {
      description = "File with admin password";
      type = lib.types.path;
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      ${service} = {
        enable = true;
        baseUrl = "https://${cfg.url}";
        passwordFile = cfg.passwordFile;
        language = "kr";
        webserver = "caddy";
        virtualHost = cfg.url;
      };
      # caddy.virtualHosts."${cfg.url}" = {
      #   useACMEHost = hl.baseDomain;
      #   extraConfig = ''
      #     reverse_proxy http://${config.services.${service}.config.LISTEN_ADDR}
      #   '';
      # };
    };
  };
}
