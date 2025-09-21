{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./secrets ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  networking = {
    hostName = "homelab";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };

  users.users.hands8142 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEm+PquO4HuABLPfaS9jwQjTFi7YofRmgitlVKMc5umO dongsu8142@naver.com"
    ];
  };

  programs = { nix-ld.enable = true; };

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
}

