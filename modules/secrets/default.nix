{ inputs, config, ... }: {
  sops.defaultSopsFile = "${inputs.secrets}/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.sshKeyPaths = [ "/home/hands8142/.ssh/id_ed25519" ];

  # sops.age.keyFile = "/home/hands8142/.config/sops/age/keys.txt";

  sops.secrets.adguard_dns_api = { group = config.services.caddy.group; };
  sops.secrets.hashed_user_password = { };
  # sops.secrets.admin_password = { owner = config.services.freshrss.user; };
}
