{ inputs, lib, config, pkgs, ... }:

with lib;

let
  cfg = config.modules.ssh-key;
in

{
  options.modules.ssh-key = { enable = mkEnableOption "ssh-key"; };
  config = mkIf cfg.enable {
    home = {
      file = {
        ".ssh/id_ed25519".source = ../../secret/id_ed25519;
        ".ssh/id_ed25519.pub".source = ../../secret/id_ed25519.pub;
      };
    };
  };
}
