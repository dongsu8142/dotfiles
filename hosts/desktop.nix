# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, ... }:

{
  imports = [../hardware/desktop.nix];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      default = 2;
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
      enabled = "kime";
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
      displayManager = {
        sessionPackages = [ inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default ];
        sddm.enable = true;
      };
      videoDrivers = ["nvidia"];
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = [
      (inputs.xdph.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland.override {
        hyprland-share-picker = inputs.xdph.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-share-picker.override {
          hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
      })
    ];
  }; 

  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    nvidia = {
      modesetting.enable = true;
    };
  };

  users.users.hands8142 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    wget
    tree
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    nanum
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        set -g theme_nerd_fonts yes
      '';
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    oci-containers = {
      backend = "podman";
    };
  };

  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

}

