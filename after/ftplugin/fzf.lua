-- after/ftplugin/fzf

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.colorcolumn = '0'
vim.opt_local.cursorlineopts = 'both'
vim.opt_local.signcolumn = 'no'

-- Remove escape mapping from fzf terminal buffer
vim.keymap.del('t', '<esc>', { buffer = true })
