--- @module 'config.colors'
--- Contains all UI color settings

-- Syntax highlighting
vim.api.nvim_set_hl(0, 'goShortVarDecl', { fg = '#ABB2BF', ctermfg = 7 })
vim.api.nvim_set_hl(0, 'goStructLiteralField', { fg = '#E06C75', ctermfg = 160 })
vim.api.nvim_set_hl(0, 'goPackageName', { fg = '#ABB2BF', ctermfg = 7 })
vim.api.nvim_set_hl(0, 'goFuncParam', { fg = '#D19A66', ctermfg = 178 })
vim.api.nvim_set_hl(0, 'goConstDeclGroup', { fg = '#D19A66', ctermfg = 178 })

vim.api.nvim_set_hl(0, '@lsp.type.parameter.go', { link = 'goFuncParam' })
vim.api.nvim_set_hl(0, '@lsp.type.namespace.go', { link = 'goPackageName' })
vim.api.nvim_set_hl(0, '@lsp.typemod.type.interface.go', { fg = '#7BE5C0', ctermfg = 86 })
vim.api.nvim_set_hl(0, '@lsp.typemod.variable.readonly.go', { link = 'goConstDeclGroup' })


-- General colors
vim.api.nvim_set_hl(0, 'Search', { bg = '#75819c', ctermbg = 67, fg = '#FFFFFF' })
vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#75819c', ctermbg = 67, fg = '#000000' })
vim.api.nvim_set_hl(0, 'IncSearch', { link = 'Search' })
