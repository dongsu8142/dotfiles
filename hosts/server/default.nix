{ config, pkgs, ... }:

{
  imports =
    (import ../../modules/virtualisation/default.nix) ++
    [./hardware-configuration.nix];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "home-server";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    firewall.enable = false;
  };

  time.timeZone = "Asia/Seoul";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  users.users.hands8142 = {
    isNormalUser = true;
    description = "hands8142";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      wget
      tree
    ];
  };

  services = {
    openssh.enable = true;
    logind = {
      lidSwitch = "ignore";
    };
    tlp.enable = true;
    auto-cpufreq.enable = true;
  };

  system = {
    autoUpgrade = {
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "23.11";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

}
