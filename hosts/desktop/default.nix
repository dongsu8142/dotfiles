{ config, pkgs, inputs, ... }:

{
  imports =
    (import ../../modules/hardware) ++
    (import ../../modules/virtualisation) ++
    [./hardware-configuration.nix] ++
    [../../modules/desktop/gnome];

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
    hostName = "home-linux";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
    };
  };

  time = {
    timeZone = "Asia/Seoul";
    hardwareClockInLocalTime = true;
  };

  i18n = {
    defaultLocale = "ko_KR.UTF-8";
    inputMethod = {
      enable = true;
      type = "kime";
    };
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
    };
    dbus.enable = true;
  };

  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  users.users.hands8142 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  programs = {
    fish.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      wget
      tree
      lm_sensors
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    nanum
    nerd-fonts.fira-code
  ];

  system = {
    autoUpgrade = {
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "24.11";
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };
}
