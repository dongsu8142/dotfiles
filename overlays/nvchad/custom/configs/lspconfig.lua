local servers = { 'tsserver', 'pyright' }
local on_attach = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.configs.lspconfig').capabilities
local lspconfig = require 'lspconfig'

for _, server in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, 'plugins.lsp.settings.' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
