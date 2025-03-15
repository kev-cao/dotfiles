local func = require('util.func')

return {
  {
    'jiangmiao/auto-pairs',
    init = function()
      vim.g.AutoPairsMultilineClose = 0
    end,
    cond = function()
      return func.check_global_var('use_auto_pairs', true, true)
    end,
  },
  {
    'tpope/vim-fugitive',
    cond = function()
      return func.check_global_var('use_fugitive', true, true)
    end
  },
  {
    'xiyaowong/virtcolumn.nvim',
    cond = function()
      return func.check_global_var('use_virtcolumn', true, true)
    end,
    init = function()
      vim.g.virtcolumn_char = ' |'
      vim.g.virtcolumn_priority = 1
    end,
  },
}
