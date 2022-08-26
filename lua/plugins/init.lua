return require('packer').startup(function(use) 
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons' -- Developer icon
  use {
    'kyazdani42/nvim-tree.lua',
    config = "require('plugins.nvim-tree')"
  } -- Tree
  use {
    'nvim-lualine/lualine.nvim',
    config = "require('plugins.lualine')"
  } -- Status bar
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    config = "require('plugins.bufferline')"
  } -- Buffer bar
  use {
    'shaunsingh/nord.nvim',
    config = "vim.cmd [[colorscheme nord]]"
  } -- Theme

  -- lsp
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'

  -- cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = "require('plugins.cmp')"
  }
  use 'L3MON4D3/LuaSnip' -- Snippet
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = "require('plugins.treesitter')"
  } -- Highlight
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = "require('plugins.null-ls')"
  } -- Formatting
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' } -- Finder
  use {
    'norcalli/nvim-colorizer.lua',
    config = "require('plugins.colorizer')"
  } -- CSS color preview
  use 'numToStr/Comment.nvim' -- Comment or uncomment
  use {
    'glepnir/dashboard-nvim',
    config = "require('plugins.dashboard')"
  } -- Dashboard
end)
