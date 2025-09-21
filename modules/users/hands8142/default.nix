{ pkgs, ... }: {
  nix.settings.trusted-users = [ "hands8142" ];

  users.users.hands8142 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEm+PquO4HuABLPfaS9jwQjTFi7YofRmgitlVKMc5umO dongsu8142@naver.com"
    ];
  };

  programs.fish.enable = true;
}
