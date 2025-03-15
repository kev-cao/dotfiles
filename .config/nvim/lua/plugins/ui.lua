--- @module 'config.ui'
--- All the UI related plugins are defined here.

local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'navarasu/onedark.nvim',
    lazy = false, -- load this during startup since it is our main plugin
    priority = 1000, -- make sure this is loaded before all other plugins
    config = function()
      vim.cmd([[colorscheme onedark]])
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      -- Nerd fonts for icons
      'nvim-tree/nvim-web-devicons'
    },
    keys = keymaps.nvim_tree.keys,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    lazy = false,
    cond = function()
      return func.check_global_var('use_nvim_tree', true, true)
    end,
    config = function()
      require('nvim-tree').setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
          theme = 'onedark',
          always_show_tabline = false,
      },
      tabline = {
        lualine_a = { 'tabs' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {  },
      }
    },
    cond = function()
      return func.check_global_var('use_lualine', true, true)
    end
  },
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    keys = keymaps.whichkey.keys,
    opts = {
      delay = 500,
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.add(keymaps.groups)
    end,
    cond = function()
      return func.check_global_var('use_which_key', true, true)
    end
  },
  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = { '<C-u>', '<C-d>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      duration_multiplier = 0.5,
    },
    config = function(_, opts)
      require('neoscroll').setup(opts)
    end,
    cond = function()
      return func.check_global_var('use_smooth_scroll', true, true)
    end
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      require('noice').setup(opts)
    end,
    cond = function()
      return func.check_global_var('use_noice', true, true)
    end
  },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.pick').setup()
    end,
  },
}
