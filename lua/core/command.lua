local command = vim.api.nvim_create_user_command

command('Format', function() vim.lsp.buf.formatting() end, {})
