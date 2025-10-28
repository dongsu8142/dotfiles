{
  config,
  lib,
  ...
}: let
  service = "miniflux";
  hl = config.homelab;
  cfg = hl.services.${service};
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {description = "Enable ${service}";};
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
      default = "Miniflux";
    };
    homepage.description = lib.mkOption {
      type = lib.types.str;
      default = "Minimalist and opinionated feed reader";
    };
    homepage.icon = lib.mkOption {
      type = lib.types.str;
      default = "miniflux-light.svg";
    };
    homepage.category = lib.mkOption {
      type = lib.types.str;
      default = "Services";
    };
    adminCredentialsFile = lib.mkOption {
      description = "File with admin credentials";
      type = lib.types.path;
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      ${service} = {
        enable = true;
        adminCredentialsFile = cfg.adminCredentialsFile;
        config = {
          BASE_URL = "https://${cfg.url}";
          CREATE_ADMIN = true;
          LISTEN_ADDR = "127.0.0.1:8067";
          # OAUTH2_PROVIDER = "oidc";
          # OAUTH2_CLIENT_ID = "miniflux";
          # OAUTH2_REDIRECT_URL = "https://${cfg.url}/oauth2/oidc/callback";
          # OAUTH2_OIDC_DISCOVERY_ENDPOINT = "https://${hl.services.keycloak.url}/realms/master";
          # OAUTH2_USER_CREATION = "1";
          DISABLE_LOCAL_AUTH = "false";
          ADMIN_USERNAME = "hands8142";
          ADMIN_PASSWORD = "kim01023.";
        };
      };
      caddy.virtualHosts."${cfg.url}" = {
        useACMEHost = hl.baseDomain;
        extraConfig = ''
          reverse_proxy http://${config.services.${service}.config.LISTEN_ADDR}
        '';
      };
    };
  };
}
