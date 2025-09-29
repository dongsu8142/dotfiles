{ pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;
      extraConfig = ''
        $env.config = {
          show_banner: false
          buffer_editor: "nvim"
          history: {
            file_format: sqlite
            max_size: 1_000_000
            sync_on_enter: true
            isolation: true
          }
          completions: {
            algorithm: "fuzzy"
          }
        }
      '';
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
      };
    };
  };
}
