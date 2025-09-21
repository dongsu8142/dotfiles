{ config, lib, ... }:
let
  service = "vaultwarden";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption { description = "Enable ${service}"; };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/bitwarden_rs";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 8222;
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "pass.${homelab.baseDomain}";
    };
    homepage.name = lib.mkOption {
      type = lib.types.str;
      default = "Vaultwarden";
    };
    homepage.description = lib.mkOption {
      type = lib.types.str;
      default = "Password manager";
    };
    homepage.icon = lib.mkOption {
      type = lib.types.str;
      default = "bitwarden.svg";
    };
    homepage.category = lib.mkOption {
      type = lib.types.str;
      default = "Services";
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      ${service} = {
        enable = true;
        config = {
          DOMAIN = "https://${cfg.url}";
          SIGNUPS_ALLOWED = false;
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = cfg.port;
          EXTENDED_LOGGING = true;
          LOG_LEVEL = "warn";
          IP_HEADER = "CF-Connecting-IP";
        };
      };
      caddy.virtualHosts."${cfg.url}" = {
        useACMEHost = homelab.baseDomain;
        extraConfig = ''
          reverse_proxy http://127.0.0.1:${toString cfg.port}
        '';
      };
    };
  };

}
