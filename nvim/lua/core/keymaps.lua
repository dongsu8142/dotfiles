local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap('n', '<C-t>', '<cmd>NvimTreeFocus<CR>', opts)
keymap('n', '<C-f>', '<cmd>Format<CR>', opts)
keymap('n', '<C-s>', '<cmd>w<CR>', opts)
keymap('n', 'ff', '<cmd>Telescope find_files<CR>', opts)
keymap('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', opts)
