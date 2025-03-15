local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'voldikss/vim-floaterm',
    keys = keymaps.floaterm.keys,
    init = function()
      vim.g.floaterm_wintype = 'split'
      vim.g.floaterm_position = 'botright'
      vim.g.floaterm_height = 0.2
    end,
    cond = function()
      return func.check_global_var('use_floaterm', true, true)
    end,
  }
}
