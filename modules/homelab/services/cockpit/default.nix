{ config, lib, ... }:
let
  service = "cockpit";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption { description = "Enable ${service}"; };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/cockpit";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 9090;
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "cockpit.${homelab.baseDomain}";
    };
    homepage.name = lib.mkOption {
      type = lib.types.str;
      default = "cockpit";
    };
    homepage.description = lib.mkOption {
      type = lib.types.str;
      default = "Web-based graphical interface for servers.";
    };
    homepage.icon = lib.mkOption {
      type = lib.types.str;
      default = "cockpit.svg";
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
        port = cfg.port;
        allowed-origins = [ "https://${cfg.url}" ];
        settings = {
          WebService = {
            ProtocolHeader = "X-Forwarded-Proto";
            AllowUnencrypted = true;
          };
        };
      };
      caddy.virtualHosts."${cfg.url}" = {
        useACMEHost = homelab.baseDomain;
        extraConfig = ''
          reverse_proxy http://127.0.0.1:${builtins.toString cfg.port}
        '';
      };
    };
  };
}
