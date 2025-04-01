--- @module 'config.session'
--- All the session related plugins are defined here.

local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'gennaro-tedesco/nvim-possession',
    dependencies = {
      'ibhagwan/fzf-lua',
    },

    build = function()
      os.execute("mkdir -p " .. vim.fn.stdpath('data') .. '/.sessions')
    end,
    lazy = false,
    keys = keymaps.nvim_possession.keys,
    config = true,
    opts = {
      sessions = {
        sessions_path = vim.fn.stdpath('data') .. '/.sessions/',
        sessions_icon = '󰦖 ',
      },
      autosave = true,
      autoload = true,
      autoprompt = true,
      autoswitch = {
        enable = true,
      },
      save_hook = function()
        if func.check_global_var('use_nvim_tree', true, false) then
          vim.cmd('NvimTreeFocus')
          vim.cmd('silent! bd')
        end
        -- Get visible buffers
        local visible_buffers = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            visible_buffers[vim.api.nvim_win_get_buf(win)] = true
        end

        local buflist = vim.api.nvim_list_bufs()
        for _, bufnr in ipairs(buflist) do
            if visible_buffers[bufnr] == nil then -- Delete buffer if not visible
                vim.cmd("silent! bd " .. bufnr)
            end
        end
      end,
      post_hook = function()
        if func.check_global_var('use_nvim_tree', true, false) then
          local nvim_tree = require('nvim-tree')
          local api = require('nvim-tree.api')
          api.tree.toggle()
          nvim_tree.change_dir(vim.fn.getcwd())
          api.tree.resize({ width = vim.g.nvim_tree_width })
        end
      end
    },
    cond = function()
      return func.check_global_var('use_nvim_possession', true, true)
    end,
  }
}
