-- after/ftplugin: git fugitive

--- Options ---

vim.opt_local.colorcolumn = '0'
vim.opt_local.cursorline = true
vim.opt_local.cursorlineopt = 'both'
vim.opt_local.foldmethod = 'syntax'
vim.opt_local.number = false
vim.opt_local.relativenumber = false

--- Keymaps ---

local opts = { buffer = true, remap = true, silent = true }
vim.keymap.set('n', '<tab>', '=', opts)
vim.keymap.set('n', 'q', 'gq', opts)
