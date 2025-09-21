{ config, lib, ... }:
let
  service = "adguardhome";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption { description = "Enable ${service}"; };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/uptime-kuma";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "adguard.${homelab.baseDomain}";
    };
    homepage.name = lib.mkOption {
      type = lib.types.str;
      default = "Adguard Home";
    };
    homepage.description = lib.mkOption {
      type = lib.types.str;
      default = "Ad blocking service";
    };
    homepage.icon = lib.mkOption {
      type = lib.types.str;
      default = "adguard-home.svg";
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
        mutableSettings = true;
        settings = {
          users = [{
            name = "hands8142";
            password =
              "$2a$12$8e2dX4fYkrSkDXJLKfIPXue3asvqoi4OVAU5Y4gXyUxQo6QIyKVq6";
          }];
          dns = {
            upstream_dns = [
              "quic://unfiltered.adguard-dns.com"
              "https://dns.cloudflare.com/dns-query"
              "https://dns.google/dns-query"
            ];
            upstream_mode = "parallel";
            enable_dnssec = true;
          };
          filtering = { filters_update_interval = 1; };
          statistics = {
            enabled = true;
            interval = "720h";
          };
          tls = {
            enabled = true;
            server_name = cfg.url;
            allow_unencrypted_doh = true;
            port_https = 4433;
          };
          filters = map (url: {
            enabled = true;
            url = url;
          }) [
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" # AdGuard DNS filter
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt" # AdAway Default Blocklist
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_25.txt" # KOR: List-KR DNS
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_15.txt" # KOR: YousList
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt" # OISD Blocklist Big
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
          ];
        };
      };
      caddy.virtualHosts."${cfg.url}" = {
        useACMEHost = homelab.baseDomain;
        extraConfig = ''
          reverse_proxy http://127.0.0.1:${builtins.toString cfg.port}
        '';
      };
    };
    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
    systemd.services.adguardhome.serviceConfig = {
      SupplementaryGroups = [ "caddy" ];
    };
  };

}
