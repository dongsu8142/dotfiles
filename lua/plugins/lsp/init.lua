local servers = { 'tsserver', 'html', 'jsonls', 'cssls', 'rust_analyzer' }
local lspconfig = require("lspconfig")
local highlight = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })
local hover = vim.api.nvim_create_augroup('LspHover', { clear = true })

require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = servers
})

local on_attach = function(client, bufnr)
  if client.supports_method('textDocument/documentHighlight') then
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = highlight
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = highlight
    })
  end
  if client.supports_method('textDocument/hover') then
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = hover })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = vim.lsp.buf.hover,
      buffer = bufnr,
      group = hover
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
