local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'zbirenbaum/copilot.lua',
    commit = '0e004a200537fe905a9a4ad7eb0ed1a2f1bb015d',
    event = { 'InsertEnter' },
    cond = function()
      return func.check_global_var('use_copilot', true, true)
    end,
    keys = keymaps.copilot.keys,
    opts = {
      copilot_node_command = '/Users/kevin/.nvm/versions/node/v22.12.0/bin/node',
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
      }
    },
    config = function(_, opts)
      require('copilot').setup(opts)
    end
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      -- curl must be installed
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      display = {
        action_palette = {
          provider = 'mini_pick',
        }
      },
      strategies = {
        chat = {
          adapter = 'copilot',
          slash_commands = {
            ['file'] = {
              opts = {
                provider = 'fzf_lua'
              }
            }
          }
        },
        inline = {
          adapter = 'copilot',
        },
      },
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = 'cmd:cat /Users/kevin/.creds/openai'
            },
            schema = {
              model = {
                default = 'gpt-4o-mini'
              }
            }
          })
        end
      }
    },
    keys = keymaps.code_companion.keys,
    config = function(_, opts)
      require('codecompanion').setup(opts)
    end,
    cond = function()
      return func.check_global_var('use_codecompanion', true, true)
    end
  }
}
