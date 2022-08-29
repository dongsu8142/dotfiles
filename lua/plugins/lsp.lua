local servers = { 'tsserver', 'html' }
local lspconfig = require("lspconfig")

require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = servers
})

for _, server in pairs(servers) do
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  lspconfig[server].setup({
    capabilities = capabilities
  })
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    update_in_insert = true
  }
)
