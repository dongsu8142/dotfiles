return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end
  },
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    opts = function()
      return require "configs.conform"
    end
  },
  {
    'vuki656/package-info.nvim',
    event = { "BufRead package.json" },
    config = function (_, _)
      require('package-info').setup()
    end
  },
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require "configs.rustaceanvim"
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
  },
  {
    'github/copilot.vim',
    lazy = false,
  }
}
