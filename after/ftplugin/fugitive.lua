-- after/ftplugin/fugitive

-- Buffer local options
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.cursorline = true
vim.opt_local.cursorlineopt = 'both'
vim.opt_local.colorcolumn = '0'
vim.opt_local.signcolumn = 'yes:1'
vim.opt_local.foldmethod = 'syntax'

-- Buffer local keymaps
local opts = { buffer = true, remap = true, silent = true }

vim.keymap.set('n', '<tab>', '=', opts)
vim.keymap.set('n', 'q', 'gq', opts)
