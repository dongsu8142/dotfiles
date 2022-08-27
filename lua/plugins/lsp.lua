local servers = { 'tsserver', 'html' }
local lspconfig = require("lspconfig")

require('nvim-lsp-installer').setup({
  ensure_installed = servers
})

for _, server in pairs(servers) do
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  lspconfig[server].setup({
    capabilities = capabilities
  })
end
