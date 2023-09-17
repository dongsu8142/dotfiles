{ config, lib, pkgs, inputs, ... }:
{
  imports = [ inputs.gBar.homeManagerModules.x86_64-linux.default ];
  xdg.configFile."gBar/style.css".source = ./style.css;
  programs.gBar = {
    enable = true;
    config = {
      EnableSNI = false;
      SNIIconSize = {
        Discord = 26;
        OBS = 23;
      };
      WorkspaceSymbols = [ " " " " ];
      UseHyprlandIPC = true;
      CPUThermalZone = "/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input";
      NetworkAdapter = "enp3s0";
    };
  };
}
