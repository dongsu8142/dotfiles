local M = {}

M.crates = {
  plugin = true,
  n = {
    ['<leader>rcu'] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      'update crates'
    },
    ['<leader>rcv'] = {
      function ()
        require('crates').show_versions_popup()
        require('crates').focus_popup()
      end,
      'show version'
    },
    ['<leader>rcf'] = {
      function ()
        require('crates').show_features_popup()
        require('crates').focus_popup()
      end,
      'show features or features details'
    }
  }
}

return M
