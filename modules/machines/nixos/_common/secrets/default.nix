{ inputs, ... }: {
  sops.defaultSopsFile = "${inputs.secrets}/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.sshKeyPaths = [ "/home/hands8142/.ssh/id_ed25519" ];

  sops.secrets.hashed_user_password = { };
}
