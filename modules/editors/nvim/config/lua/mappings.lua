require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>rcu", function()
  require('crates').upgrade_all_crates()
end, { desc = "Update crates" })
map("n", "<leader>rcv", function()
  require('crates').show_versions_popup()
  require('crates').focus_popup()
end, { desc = "Show version" })
map("n", "<leader>rcf", function()
  require('crates').show_features_popup()
  require('crates').focus_popup()
end, { desc = "Show features or features details" })
