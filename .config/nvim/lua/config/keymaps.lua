--- @module 'config.keymaps'
--- All the keymappings are defined here.
-- Note: except for autocomplete keymaps, which are found in plugins/cmp.lua

local M = {}

M.groups = {
  { '<leader>s', group = 'Search' },
  { '<leader>g', group = 'Git', icon = { icon = '', color = 'green' } },
  { '<leader>d', group = 'Debugger', icon = { icon = '󰨰', color = 'blue' } },
  { '<leader>dt', group = 'Debug Tests', icon = { icon = '󰨰', color = 'blue' } },
  { '<leader><S-t>', group = 'Tests', icon = { icon = '', color = 'blue' } },
  { '<leader>t', group = 'Terminal' },
  { '<leader>l', group = 'LSP', icon = { icon = '', color = 'red' } },
  { '<leader>a', group = 'AI', icon = { icon = '󱚤', color = 'green' } },
  { '<leader>S', group = 'Sessions', icon = { icon = '󰦖', color = 'green' } },
}

-- General keymaps that should always be loaded
M.general = {
  keys = {
    {
      '<C-q>',
      '<cmd>tabn<CR>',
      mode = 'n',
      desc = 'Next tab'
    },
    {
      '<S-q>',
      '<cmd>tabp<CR>',
      mode = 'n',
      desc = 'Previous tab'
    },
    {
      '<S-Up>',
      '<cmd>resize +2<CR>',
      mode = 'n',
      desc = 'Increase window height'
    },
    {
      '<S-Down>',
      '<cmd>resize -2<CR>',
      mode = 'n',
      desc = 'Decrease window height'
    },
    {
      '<S-Right>',
      '<cmd>vertical resize +2<CR>',
      mode = 'n',
      desc = 'Increase window width'
    },
    {
      '<S-Left>',
      '<cmd>vertical resize -2<CR>',
      mode = 'n',
      desc = 'Decrease window width'
    },
    {
      'q:',
      '<nop>',
      hidden = true,
      mode = 'n'
    },
    {
      '<Esc><Esc>',
      '<C-\\><C-n>',
      mode = 't',
      desc = 'Exit terminal mode',
    }
  }
}

M.fzf = {
  keys = {
    {
      '<leader>sf',
      '<cmd>FzfLua files<CR>',
      mode = 'n',
      desc = 'Search files'
    },
    {
      '<leader>sb',
      '<cmd>FzfLua buffers<CR>',
      mode = 'n',
      desc = 'Search buffers'
    },
    {
      '<leader>sm',
      '<cmd>FzfLua marks<CR>',
      mode = 'n',
      desc = 'Search tabs'
    },
    {
      '<leader>sr',
      '<cmd>FzfLua grep_project<CR>',
      mode = 'n',
      desc = 'Search in project files'
    },
    {
      '<leader>gb',
      '<cmd>FzfLua git_branches<CR>',
      mode = 'n',
      desc = 'List git branches'
    }
  }
}

M.floaterm = {
  keys = {
    {
      '<leader>t',
      '<cmd>FloatermToggle<CR>',
      mode = 'n',
      desc = 'Toggle terminal'
    },
    {
      '<leader>t',
      '<C-\\><C-n><cmd>FloatermToggle<CR>',
      mode = 't',
      desc = 'Toggle terminal'
    },
    {
      '<leader>n',
      '<C-\\><C-n><cmd>FloatermNew<CR>',
      mode = 't',
      desc = 'New terminal'
    },
    {
      '<leader>l',
      '<C-\\><C-n><cmd>FloatermNext<CR>',
      mode = 't',
      desc = 'Next terminal'
    },
    {
      '<leader>h',
      '<C-\\><C-n><cmd>FloatermPrev<CR>',
      mode = 't',
      desc = 'Previous terminal'
    }
  }
}

M.nvim_tree = {
  keys = {
    {
      '<C-n>',
      '<cmd>NvimTreeFocus<CR>',
      mode = 'n',
      desc = 'Focus on nvim-tree'
    },
    {
      '<C-b>',
      '<cmd>NvimTreeToggle<CR>',
      mode = 'n',
      desc = 'Toggle nvim-tree'
    },
    {
      '<C-f>',
      '<cmd>NvimTreeFindFile<CR>',
      mode = 'n',
      desc = 'Find file in nvim-tree'
    }
  }
}

M.lsp = {
  keys = {
    {
      'gd',
      '<cmd>FzfLua lsp_definitions<CR>',
      mode = 'n',
      desc = 'Go to definition'
    },
    {
      'gi',
      '<cmd>FzfLua lsp_implementations<CR>',
      mode = 'n',
      desc = 'List implementations'
    },
    {
      'gr',
      '<cmd>FzfLua lsp_references<CR>',
      mode = 'n',
      desc = 'List references'
    },
    {
      '<F2>',
      '<cmd>lua vim.lsp.buf.rename()<CR>',
      mode = 'n',
      desc = 'Rename reference'
    },
    {
      '<C-k>',
      '<cmd>lua vim.lsp.buf.hover()<CR>',
      mode = 'n',
      desc = 'Show documentation'
    },
    {
      '<C-k>',
      '<cmd>lua vim.lsp.buf.signature_help()<CR>',
      mode = 'i',
      desc = 'Show signature'
    },
    {
      '<leader>ld',
      '<cmd>FzfLua diagnostics_document<CR>',
      mode = 'n',
      desc = 'Show buffer diagnostics'
    },
    {
      '<leader>l<S-d>',
      '<cmd>FzfLua diagnostics_workspace<CR>',
      mode = 'n',
      desc = 'Show workspace diagnostics'
    },
    {
      '<leader>lj',
      '<cmd>lua vim.diagnostic.goto_next()<CR>',
      mode = 'n',
      desc = 'Next diagnostic'
    },
    {
      '<leader>lk',
      '<cmd>lua vim.diagnostic.goto_prev()<CR>',
      mode = 'n',
      desc = 'Previous diagnostic'
    },
    {
      '<leader>lc',
      '<cmd>FzfLua lsp_code_actions<CR>',
      mode = 'n',
      desc = 'Code actions'
    },
    {
      '<leader>l<S-s>',
      '<cmd>FzfLua lsp_live_workspace_symbols<CR>',
      mode = 'n',
      desc = 'Live workspace symbols'
    },
    {
      '<leader>ls',
      '<cmd>FzfLua treesitter<CR>',
      mode = 'n',
      desc = 'List buffer symbols'
    },
    {
      '<leader>lh',
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}), {0})
      end,
      mode = 'n',
      desc = 'Toggle inlay hints'
    }
  }
}

M.dap = {
  keys = {
    {
      '<leader>db',
      '<cmd>DapToggleBreakpoint<CR>',
      mode = 'n',
      desc = 'Toggle breakpoint'
    },
    {
      '<leader>dfb',
      '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
      mode = 'n',
      desc = 'Set conditional breakpoint'
    },
    {
      '<leader>dlb',
      '<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
      mode = 'n',
      desc = 'Set log breakpoint'
    },
    {
      '<leader>dc',
      '<cmd>DapContinue<CR>',
      mode = 'n',
      desc = '[Debugger] Continue'
    },
    {
      '<leader>ds',
      '<cmd>DapStepOver<CR>',
      mode = 'n',
      desc = '[Debugger] Step over',
    },
    {
      '<leader>di',
      '<cmd>DapStepInto<CR>',
      mode = 'n',
      desc = '[Debugger] Step into'
    },
    {
      '<leader>do',
      '<cmd>DapStepOut<CR>',
      mode = 'n',
      desc = '[Debugger] Step out'
    },
    {
      '<leader>dd',
      '<cmd>DapDisconnect<CR>',
      mode = 'n',
      desc = '[Debugger] Disconnect'
    },
    {
      '<leader>dx',
      '<cmd>DapTerminate<CR>',
      mode = 'n',
      desc = '[Debugger] Terminate'
    },
    -- Since I'm always going to be using dap-ui with dap, I'm going to include
    -- dap-ui keymaps in the dap keymaps.
    {
      '<leader>du',
      '<cmd>lua require(\'dapui\').toggle()<CR>',
      mode = 'n',
      desc = 'Toggle dap-ui'
    },
    {
      '<leader>de',
      '<cmd>lua require(\'dapui\').eval(vim.fn.input("Evaluate expression: "))<CR>',
      mode = 'n',
      desc = 'Evaluate expression'
    },
  }
}

M.dapgo = {
  keys = {
    {
      '<leader>dtt',
      '<cmd>lua require("dap-go").debug_test()<CR>',
      mode = 'n',
      desc = 'Debug nearest test'
    },
    {
      '<leader>dtl',
      '<cmd>lua require("dap-go").debug_last_test()<CR>',
      mode = 'n',
      desc = 'Debug last test'
    },
  }
}

M.whichkey = {
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = true })
      end,
      mode = 'n',
      desc = 'Show keymaps'
    }
  }
}

M.test = {
  keys = {
    {
      '<leader><S-t>s',
      '<cmd>TestSuite<CR>',
      mode = 'n',
      desc = 'Run test suite'
    },
    {
      '<leader><S-t>f',
      '<cmd>TestFile<CR>',
      mode = 'n',
      desc = 'Run test file'
    },
    {
      '<leader><S-t>t',
      '<cmd>TestNearest<CR>',
      mode = 'n',
      desc = 'Run nearest test'
    },
    {
      '<leader><S-t>l',
      '<cmd>TestLast<CR>',
      mode = 'n',
      desc = 'Run last test'
    },
    {
      '<leader><S-t>g',
      '<cmd>TestVisit<CR>',
      mode = 'n',
      desc = 'Go to last test'
    },
  }
}

M.code_companion = {
  keys = {
    {
      '<leader>aa',
      '<cmd>CodeCompanionActions<CR>',
      mode = 'n',
      desc = 'Code companion actions',
    },
    {
      '<leader>aa',
      '<cmd>CodeCompanionActions<CR>',
      mode = 'n',
      desc = 'Code companion actions',
    },
  }
}

M.nvim_possession = {
  keys = {
    {
      '<leader>Sl',
      function()
        require('nvim-possession').list()
      end,
      mode = 'n',
      desc = 'List sessions'
    },
    {
      '<leader>Sn',
      function()
        require('nvim-possession').new()
      end,
      mode = 'n',
      desc = 'New session'
    },
    {
      '<leader>Su',
      function()
        require('nvim-possession').update()
      end,
      mode = 'n',
      desc = 'Update session'
    },
    {
      '<leader>Sd',
      function()
        require('nvim-possession').delete()
      end,
      mode = 'n',
      desc = 'Delete session'
    }
  }
}

return M
