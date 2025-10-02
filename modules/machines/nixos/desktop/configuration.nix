{ config, ... }:

{
  imports = [ ./hardware-configuration.nix ./disko.nix ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      default = "saved";
    };
  };

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  time.hardwareClockInLocalTime = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "kime";
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  desktop = {
    enable = true;
    cosmic.enable = true;
  };
}

