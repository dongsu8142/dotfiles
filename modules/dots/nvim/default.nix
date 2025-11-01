{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        clipboard.enable = true;
        theme = {
          enable = true;
          name = "nord";
          style = "dark";
        };

        options = {
          shiftwidth = 2;
          tabstop = 2;
        };

        syntaxHighlighting = true;
        lazy.enable = true;
        git.enable = true;
        binds.whichKey.enable = true;
        ui.noice.enable = true;
        mini.pairs.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        utility.snacks-nvim = {
          enable = true;
          setupOpts = {
            indent.enabled = true;
            scroll.enabled = true;
          };
        };

        tabline.nvimBufferline = {
          enable = true;
          setupOpts.options.always_show_bufferline = false;
        };

        filetree = {
          neo-tree = {
            enable = true;
            setupOpts = {
              close_if_last_window = true;
              enable_diagnostics = true;
              enable_git_status = true;
              enable_modified_markers = true;
              open_files_in_last_window = true;
            };
          };
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lspconfig.enable = true;
        };

        treesitter = {
          enable = true;
          context = {
            enable = true;
          };
          highlight = {
            enable = true;
          };
        };

        languages = {
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true;
          go.enable = true;
          ts = {
            enable = true;
            extensions.ts-error-translator.enable = true;
          };
          rust = {
            enable = true;
            crates = {
              enable = true;
            };
          };
        };

        maps.normal = {
          "<leader>e" = {
            desc = "Toogle Neotree";
            action = "<cmd>Neotree toggle reveal<cr>";
          };
        };
      };
    };
  };
}
