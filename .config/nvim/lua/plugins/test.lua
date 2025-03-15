local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'klen/nvim-test',
    event = {'VeryLazy'},
    keys = keymaps.test.keys,
    opts = {
      termOpts = {
        direction = 'horizontal',
        height = 12,
        go_back = true,
      }
    },
    config = function(_, opts)
      require('nvim-test').setup(opts)
    end,
    cond = function()
      return func.check_global_var('use_nvim_test', true, true)
    end
  }
}
