{pkgs, ...}: {
  home.packages = with pkgs; [gcc gh lazygit];
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "dongsu8142";
          email = "dongsu8142@naver.com";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
    bash.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };
}
