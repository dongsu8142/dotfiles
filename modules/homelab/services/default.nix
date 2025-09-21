{ config, lib, pkgs, ... }: {
  options.homelab.services = {
    enable = lib.mkEnableOption "Settings and services for the homelab";
  };

  config = lib.mkIf config.homelab.services.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    security.acme = {
      acceptTerms = true;
      defaults.email = "dongsu8142@naver.com";
      certs.${config.homelab.baseDomain} = {
        reloadServices = [ "caddy.service" ];
        domain = "${config.homelab.baseDomain}";
        extraDomainNames = [ "*.${config.homelab.baseDomain}" ];
        dnsProvider = "cloudflare";
        dnsResolver = "1.1.1.1:53";
        dnsPropagationCheck = true;
        group = config.services.caddy.group;
        environmentFile = config.homelab.cloudflare.dnsCredentialsFile;
      };
    };
    services.caddy = {
      enable = true;
      globalConfig = ''
        auto_https off
      '';
      virtualHosts = {
        "http://${config.homelab.baseDomain}" = {
          extraConfig = ''
            redir https://{host}{uri}
          '';
        };
        "http://*.${config.homelab.baseDomain}" = {
          extraConfig = ''
            redir https://{host}{uri}
          '';
        };
        "https://${config.homelab.baseDomain}" = {
          extraConfig = ''
            respond "404 Not Found" 404
          '';
        };
        "https://*.${config.homelab.baseDomain}" = {
          extraConfig = ''
            respond "404 Not Found" 404
          '';
        };
      };
    };
  };

  imports = [
    ./homepage
    ./adguardhome
    ./uptime-kuma
    ./vaultwarden
    ./cockpit
    ./freshrss
    ./immich
  ];
}
