{ pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;
      shellAliases = { };
      configFile = {
        source = ./config.nu;
      };
      envFile = {
        source = ./env.nu;
      };
    };
  };
}
