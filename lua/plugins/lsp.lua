local servers = { 'tsserver', 'html' }
local lspconfig = require("lspconfig")

require('nvim-lsp-installer').setup({
  ensure_installed = servers
})

for _, server in pairs(servers) do
  lspconfig[server].setup({})
end
