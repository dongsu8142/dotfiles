require "nvchad.autocmds"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local buf = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(buf)
    end
  end
})
