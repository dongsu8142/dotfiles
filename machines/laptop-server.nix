{ config, pkgs, ... }:

{
  imports = 
  [
    ./shared.nix
    ../hardware/laptop.nix
  ];

  networking = {
    networkmanager = {
      wifi.powersave = false;
    };
  };

  services = {
    logind = {
      lidSwitch = "ignore";
    };
  };
}
