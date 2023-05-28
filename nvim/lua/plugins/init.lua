local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine')
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    config = function()
      require('plugins.bufferline')
    end,
  },
  {
    'shaunsingh/nord.nvim',
    config = function()
      require('plugins.nord')
    end,
  },
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
  },
  'williamboman/mason-lspconfig.nvim',
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lsp')
    end,
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.cmp')
    end,
  },
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('plugins.null-ls')
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  'windwp/nvim-ts-autotag',
  'mrjones2014/nvim-ts-rainbow',
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup()
    end,
  },
  'sindrets/diffview.nvim'
}

local opts = {}

require('lazy').setup(plugins, opts)
