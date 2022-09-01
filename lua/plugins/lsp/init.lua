local servers = { 'tsserver', 'html', 'jsonls' }
local lspconfig = require("lspconfig")
local augroup = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })

require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = servers
})

local on_attach = function(client, bufnr)
  if client.supports_method('textDocument/documentHighlight') then
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = function() vim.lsp.buf.document_highlight() end,
      buffer = bufnr,
      group = augroup,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = augroup
    })
  end
end

for _, server in pairs(servers) do
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  local has_custom_opts, server_custom_opts = pcall(require, 'plugins.lsp.settings.' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    update_in_insert = true
  }
)