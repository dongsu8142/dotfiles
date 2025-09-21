{ config, ... }: {
  sops.secrets.adguard_dns_api = { group = config.services.caddy.group; };
}
