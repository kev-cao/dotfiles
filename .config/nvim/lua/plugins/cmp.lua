--- @module 'config.cmp'
--- All the completion related plugins are defined here.  

local func = require('util.func')

return {
  {
    'hrsh7th/nvim-cmp',
    cond = function()
      return func.check_global_var('use_cmp', true, true)
    end,
    config = function()
      local cmp = require('cmp')
      local has_luasnip, luasnip = pcall(require, 'luasnip')
      local opts = {
        mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
                if has_luasnip and luasnip.expandable() then
                    luasnip.expand()
                else
                    cmp.confirm({ select = true })
                end
            else
                fallback()
            end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_luasnip and luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif has_luasnip and luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'lazydev', group_index = 0 }
        }),
        completion = {
          completeopt = 'noselect',
        },
        preselect = cmp.PreselectMode.None,
      }
      cmp.setup(opts)
    end
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {
      'hrsh7th/nvim-cmp'
    },
  },
  {
    'hrsh7th/cmp-buffer',
    dependencies = {
      'hrsh7th/nvim-cmp'
    },
    cond = function()
      return func.check_global_var('use_cmp_buffer', true, true)
    end,
  },
  {
    'hrsh7th/cmp-path',
    dependencies = {
      'hrsh7th/nvim-cmp'
    },
    cond = function()
      return func.check_global_var('use_cmp_path', true, true)
    end,
  },
  {
    'hrsh7th/cmp-cmdline',
    dependencies = {
      'hrsh7th/nvim-cmp'
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
      })

      cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          }),
          matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
    cond = function()
      return func.check_global_var('use_cmp_cmdline', true, true)
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/nvim-cmp'
    },
    cond = function()
      return func.check_global_var('use_snippet', true, true)
    end,
  },
  {
    'rafamadriz/friendly-snippets',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    }
  }
}
