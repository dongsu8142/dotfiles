{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.modules.nvim;
in

{
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    home.file.".config/nvim/lua".source = ./lua;
    # xdg.configFile."nvim/init.lua".source = ./init.lua;

    home.packages = with pkgs; [
      nodePackages.typescript-language-server # tsserver
      nodePackages.vscode-json-languageserver # jsonls
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        # dependency
        plenary-nvim
        nvim-web-devicons

        # ui
        nvim-tree-lua
        lualine-nvim
        {
          plugin =  bufferline-nvim;
          type = "lua";
          config = "require('bufferline').setup()";
        }
        nord-nvim

        # lsp
        nvim-lspconfig

        # completion
        luasnip
        cmp_luasnip
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        nvim-cmp
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = "require('nvim-autopairs').setup()";
        }

        # tool
        gitsigns-nvim
        diffview-nvim
        SchemaStore-nvim
        {
          plugin = comment-nvim;
          type = "lua";
          config = "require('Comment').setup()";
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = "require('indent_blankline').setup()";
        }

        # syntax
        nvim-treesitter.withAllGrammars
        nvim-ts-autotag
        nvim-ts-rainbow
        {
          plugin = nvim-colorizer-lua;
          type = "lua";
          config = "require('colorizer').setup()";
        }
      ];
      extraConfig = ''
        lua << EOF
        require('config')
        require('plugins')
        EOF'';
    };
  };
}
