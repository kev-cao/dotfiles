--- @module 'general.lua'
--- This contains general settings that don't fit into any other category

-- Enabling and disabling plugins
vim.g.use_fzf = true
vim.g.use_treesitter_context = true
vim.g.use_auto_pairs = true
vim.g.use_fugitive = true
vim.g.use_gitsigns = true
vim.g.use_virtcolumn = false -- bug with covering text, waiting for https://github.com/xiyaowong/virtcolumn.nvim/pull/11
vim.g.use_copilot = true
vim.g.use_codecompanion = true
vim.g.use_cmp = true
vim.g.use_cmp_buffer = true
vim.g.use_cmp_path = true
vim.g.use_cmp_cmdline = true
vim.g.use_snippet = true
vim.g.use_lsp = true
vim.g.use_treesitter = true
vim.g.use_floaterm = true
vim.g.use_nvim_tree = true
vim.g.use_lualine = true
vim.g.use_dap_ui = true
vim.g.use_which_key = true
vim.g.use_smooth_scroll = true
vim.g.use_nvim_test = true
vim.g.use_noice = true
vim.g.use_minipick = true
vim.g.use_nvim_possession = true
vim.g.use_mini_surround = true
vim.g.use_neoclip = true
vim.g.use_todo_comments = true
vim.g.use_vim_sleuth = true
vim.g.use_colorizer = true
vim.g.use_lazygit = true
vim.g.use_autotag = true

vim.g.nvim_tree_width = 30

vim.opt.colorcolumn = { '80', '100' }
vim.opt.hlsearch = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.textwidth = 100
vim.opt.formatoptions:remove('tc') -- Prevent autowrapping of comments and text
vim.opt.ruler = true
vim.opt.cmdheight = 1
vim.opt.updatetime = 750
vim.opt.signcolumn = 'yes'
vim.opt.guicursor = "n-v-c-sm:block-blinkwait100-blinkoff20-blinkon20," ..
    "i-ci-ve:ver25-blinkwait100-blinkoff20-blinkon20," ..
    "r-cr-o:hor20-blinkwait100-blinkoff20-blinkon20"
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ssop:append({ 'curdir' })
vim.opt.ssop:remove('blank')


vim.g.floaterm_wintype = 'split'
vim.g.floaterm_position = 'botright'
vim.g.floaterm_width = 0.2

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
vim.g.vimtex_quickfix_ignore_filters = {
  'Underfull',
  'Overfull',
  'does not make sense',
  'Non standard sectioning'
}

-- Create the Terminal command using the API.
vim.api.nvim_create_user_command('Terminal', 'botright vs | term', {})

-- Set up command-line abbreviations.
vim.cmd('cabbrev terminal Terminal')
vim.cmd('cabbrev term Terminal')

--[[
-- ==========================================================
-- ==================== Auto Commands =======================
-- ==========================================================
--]]
vim.api.nvim_create_augroup('formatter', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'formatter',
  pattern = '*.go',
  callback = function(args)
    -- args.file holds the current file name
    local file = args.file
    -- Build the command using the COCKROACH_ROOT environment variable and shellescape the file path.
    local cmd = vim.env.COCKROACH_ROOT .. '/bin/crlfmt -w -tab=2 ' .. vim.fn.shellescape(file)
    -- Execute the command silently (errors ignored)
    os.execute(cmd)
    vim.cmd('edit')
  end,
})

-- Don't clear the clipboard on exit
vim.api.nvim_create_autocmd('VimLeave', {
  pattern = '*',
  callback = function()
    local clip = vim.fn.getreg('+')
    local esc = vim.fn.shellescape(clip)
    local cmd = 'echo ' .. esc .. ' | xclip -selection clipboard'
    vim.fn.system(cmd)
  end,
})

