local plugins = {
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspconfig'
    end,
  },
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    dependencies = 'neovim/nvim-lspconfig',
    opts = function()
      return require 'custom.configs.rust-tools'
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function (_, opts)
      local crates = require 'crates'
      crates.setup(opts)
      crates.show()
      require("core.utils").load_mappings("crates")
    end
  }
}
return plugins
