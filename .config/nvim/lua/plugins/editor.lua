local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'windwp/nvim-ts-autotag',
    cond = function()
      return func.check_global_var('use_autotag', true, true)
    end,
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'tpope/vim-sleuth',
    cond = function()
      return func.check_global_var('use_sleuth', true, true)
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { icon = " ", color = "default" },
        HACK = { icon = " ", color = "warning" },
        WARN = {
          icon = " ",
          color = "warning",
          alt = { "WARNING", "XXX" },
        },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "info", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      search = {
        pattern = [[\b(KEYWORDS)\s*(\([^\)]*\))?\s*:]]
      },
      highlight = {
        pattern = [[.*<((KEYWORDS)\s*%(\(.{-1,}\))?)\s*:]]
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#E06C75" },
        warning = { "DiagnosticWarn", "WarningMsg", "#E5C07B" },
        info = { "DiagnosticInfo", "#54ACE3" },
        hint = { "DiagnosticHint", "#98C379" },
        default = { "#C678DD" },
        test = { "Identifier", "#56B6C2" }
      },
    },
    cond = function()
      return func.check_global_var('use_todo_comments', true, true)
    end,
    config = function(_, opts)
      -- Unfortunately this plugin does not support case insensitivity, so 
      -- this is a workaround to add some case insensitivity.
      for key, _ in pairs(opts.keywords) do
        if opts.keywords[key].alt == nil then
          opts.keywords[key].alt = {}
        end
        table.insert(opts.keywords[key].alt, key:lower())
        table.insert(opts.keywords[key].alt, key:capitalize())
      end
      require('todo-comments').setup(opts)
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    build = function()
      os.execute('mkdir -p ' .. vim.fn.stdpath('data') .. '/databases')
    end,
    dependencies = {
      {'kkharji/sqlite.lua', module = 'sqlite'},
      {'ibhagwan/fzf-lua'},
    },
    cond = function()
      return func.check_global_var('use_neoclip', true, true)
    end,
    keys = keymaps.neoclip.keys,
    opts = {
      enable_persistent_history = true,
    },
    config = function(_, opts)
      require('neoclip').setup(opts)
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    cond = function()
      return func.check_global_var('use_mini_surround', true, true)
    end,
    opts = {
      mappings = {
        add = '<S-s>a', -- Add surrounding in Normal and Visual modes
        delete = '<S-s>d', -- Delete surrounding
        find = '<S-s>f', -- Find surrounding (to the right)
        find_left = '<S-s>F', -- Find surrounding (to the left)
        highlight = '<S-s>h', -- Highlight surrounding
        replace = '<S-s>r', -- Replace surrounding
        update_n_lines = '<S-s>n', -- Update `n_lines`

        suffix_last = '',
        suffix_next = '',
      },
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end,
  },
  {
    'cohama/lexima.vim',
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
