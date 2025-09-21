{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ./modules/homelab ./modules/secrets ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  time.timeZone = "Asia/Seoul";

  networking = {
    hostName = "homelab";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };

  users.users.hands8142 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree ];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.hashed_user_password.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEm+PquO4HuABLPfaS9jwQjTFi7YofRmgitlVKMc5umO dongsu8142@naver.com"
    ];
  };

  programs = {
    fish.enable = true;
    nix-ld.enable = true;
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      vim
      wget
      git
      nettools
      unzip
      # (rust-bin.selectLatestNightlyWith (toolchain:
      #   toolchain.default.override {
      #     extensions = [ "rust-src" "rust-analyzer" "rustfmt" "clippy" ];
      #     targets = [ "wasm32-unknown-unknown" "x86_64-unknown-linux-gnu" ];
      #   }))
      age
    ];
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    logind = { settings.Login.HandleLidSwitch = "ignore"; };
    tlp.enable = true;
    auto-cpufreq.enable = true;
  };

  homelab = {
    enable = true;
    baseDomain = "hdsu.net";
    timeZone = "Asia/Seoul";
    cloudflare.dnsCredentialsFile = config.sops.secrets.adguard_dns_api.path;
    services = {
      enable = true;
      homepage = { enable = true; };
      adguardhome = { enable = true; };
      uptime-kuma = { enable = true; };
      vaultwarden = { enable = true; };
      immich = { enable = true; };
      freshrss = {
        enable = false;
        passwordFile = config.sops.secrets.admin_password.path;
      };
      cockpit = { enable = false; };
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "25.11";

}

