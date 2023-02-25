local command = vim.api.nvim_create_user_command

command('Format', function()
  -- nvim 0.8+
  vim.lsp.buf.format({
    filter = function(server)
      return server.name == 'null-ls'
    end
  })
end, {})
