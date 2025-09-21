{ config, pkgs, lib, ... }: {
  system.stateVersion = "25.11";

  imports = [ ./secrets ./nix ];

  time.timeZone = "Asia/Seoul";

  users.users = {
    hands8142 = {
      hashedPasswordFile = config.sops.secrets.hashed_user_password.path;
    };
    root = {
      initialHashedPassword = config.sops.secrets.hashed_user_password.path;
    };
  };

  programs.fish.enable = true;
  programs.git.enable = true;
  programs.mosh.enable = true;
  programs.htop.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };

  environment = {
    shells = [ pkgs.fish ];
    systemPackages = with pkgs; [ wget unzip nettools lm_sensors ];
  };
}
