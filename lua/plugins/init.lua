return require('packer').startup(function(use) 
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'kyazdani42/nvim-tree.lua',
    config = "require('plugins.nvim-tree')"
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = "require('plugins.lualine')"
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    config = "require('plugins.bufferline')"
  }
  use {
    'shaunsingh/nord.nvim',
    config = "vim.cmd [[colorscheme nord]]"
  }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {
    'neovim/nvim-lspconfig',
    config = "require('plugins.lsp')"
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = "require('plugins.cmp')"
  }
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = "require('plugins.treesitter')"
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = "require('plugins.null-ls')"
  }
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
  use {
    'norcalli/nvim-colorizer.lua',
    config = "require('colorizer').setup()"
  }
  use {
    'numToStr/Comment.nvim',
    config = "require('Comment').setup()"
  }
  use {
    'glepnir/dashboard-nvim',
    config = "require('plugins.dashboard')"
  }
  use 'windwp/nvim-ts-autotag'
  use 'p00f/nvim-ts-rainbow'
  use {
    'windwp/nvim-autopairs',
    config = "require('nvim-autopairs').setup()"
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = "require('plugins.gitsigns')"
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = "require('indent_blankline').setup()"
  }
  use {
    'antoinemadec/FixCursorHold.nvim',
    config = 'vim.g.cursorhold_updatetime = 1000'
  }
end)
