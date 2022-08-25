return require('packer').startup(function(use) 
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons' -- Developer icon
  use 'kyazdani42/nvim-tree.lua' -- Tree
  use 'nvim-lualine/lualine.nvim' -- Status bar
  use { 'akinsho/bufferline.nvim', tag = "v2.*" } -- Buffer bar
  use 'shaunsingh/nord.nvim' -- Theme
  -- lsp
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'

  -- cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip' -- Snippet
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  } -- Highlight
  use 'jose-elias-alvarez/null-ls.nvim' -- Formatting
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' } -- Finder
  use 'norcalli/nvim-colorizer.lua' -- CSS color preview
  use 'numToStr/Comment.nvim' -- Comment or uncomment
  use 'glepnir/dashboard-nvim' -- Dashboard
end)
