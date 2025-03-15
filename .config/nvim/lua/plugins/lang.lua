--- @module 'plugins.lang'
--- Language server and static syntax plugins

local func = require('util.func')
local keymaps = require('config.keymaps')
local async = require('lspconfig.async')
local util = require('lspconfig/util')

local mod_cache = nil

return {
  {
    'neovim/nvim-lspconfig',
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    dependencies = {
      -- Gopls and Node should be installed
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'junegunn/fzf',
    },
    opts = {
      capabilities = {}, -- Global capabilities 
      servers = { -- Custom server options for nvim-lspconfig
        gopls = {
          on_attach = function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes},
                range = true,
              }
            end
          end,
          cmd = {'gopls'},
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          root_dir = function(fname)
            -- see: https://github.com/neovim/nvim-lspconfig/issues/804
            if not mod_cache then
              local result = async.run_command { 'go', 'env', 'GOMODCACHE' }
              if result and result[1] then
                mod_cache = vim.trim(result[1])
              else
                mod_cache = vim.fn.system 'go env GOMODCACHE'
              end
            end
            if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
              local clients = util.get_lsp_clients { name = 'gopls' }
              if #clients > 0 then
                return clients[#clients].config.root_dir
              end
            end
            return util.root_pattern('go.work', 'go.mod', '.git')(fname)
          end,
          single_file_support = true,
          settings = {
            gopls = {
              semanticTokens = true,
              staticcheck = true,
              hints = {
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        },
        lua_ls = {
          cmd = { 'lua-language-server' },
          settings = {
            Lua = {
              diagnostics = {
                enable = true,
                globals = { 'vim' },
              },
            },
          },
        }
      },
    },
    config = function(_, opts)
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        require('cmp_nvim_lsp').default_capabilities(),
        vim.lsp.protocol.make_client_capabilities(),
        opts.capabilities or {}
      )
      local function on_attach(client, bufnr)
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup('lsp_hover', { clear = false })
          vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_hover' })
          vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            group = 'lsp_hover',
            callback = vim.lsp.buf.document_highlight
          })
          vim.api.nvim_create_autocmd('CursorHoldI', {
            buffer = bufnr,
            group = 'lsp_hover',
            callback = vim.lsp.buf.document_highlight
          })
          vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = bufnr,
            group = 'lsp_hover',
            callback = vim.lsp.buf.clear_references
          })
        end
      end
      require('mason').setup({
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      })
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local server = opts.servers[server_name]
          local server_on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            if server and server.on_attach then
              server.on_attach(client, bufnr)
            end
          end
          local server_opts = vim.tbl_deep_extend(
            'force',
            {
              capabilities = vim.deepcopy(capabilities),
              handlers = {
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                  border = 'rounded',
                })
              }
            },
            server or {},
            { on_attach = server_on_attach }
          )
          require('lspconfig')[server_name].setup(server_opts)
        end
      })
    end,
    keys = keymaps.lsp.keys,
    cond = function()
      return func.check_global_var('use_lsp', true, true)
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    -- C compiler and libstdc++ must be installed
    -- Git must be installed as well as tar/curl
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash', 'c', 'css', 'go', 'gitignore', 'gomod', 'gosum',
          'gowork', 'html', 'javascript', 'typescript', 'json', 'lua',
          'markdown', 'python', 'yaml'
        },
        auto_install = true,
        sync_install = true,
        highlight = {
          enable = true,
          disable = function(_, bufnr) -- Disable in files with more than 5K
            return vim.api.nvim_buf_line_count(bufnr) > 5000
          end,
        }
      })
    end,
    build = ":TSUpdate",
    cond = function()
      return func.check_global_var('use_treesitter', true, true)
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    opts = {
      max_lines = 3,
    },
    cond = function()
      return func.check_global_var('use_treesitter_context', true, true)
    end,
  },
  {
    'charlespascoe/vim-go-syntax',
    ft = { 'go', 'gomod', 'gowork', 'gotmpl' },
  },
    {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
