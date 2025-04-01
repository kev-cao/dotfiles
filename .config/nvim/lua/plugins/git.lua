local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
    },
    cond = function()
      return func.check_global_var('use_lazygit', true, true)
    end,
    keys = keymaps.lazygit.keys,
  },
  {
    'tpope/vim-fugitive',
    keys = keymaps.fugitive.keys,
    cond = function()
      return func.check_global_var('use_fugitive', true, true)
    end
  },
  {
    'tpope/vim-rhubarb',
    dependencies = {
      {'tpope/vim-fugitive'}
    },
    cond = function()
      return func.check_global_var('use_fugitive', true, true)
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    keys = keymaps.gitsigns.keys,
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('gitsigns').setup()
    end,
    cond = function()
      return func.check_global_var('use_gitsigns', true, true)
    end,
  },
}
