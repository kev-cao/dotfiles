local func = require('util.func')
local keymaps = require('config.keymaps')

return {
  {
    'github/copilot.vim',
    cond = function()
      return func.check_global_var('use_copilot', true, true)
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
