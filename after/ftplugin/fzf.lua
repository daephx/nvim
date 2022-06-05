-- after/ftplugin: FZF

-- Options
vim.opt_local.colorcolumn = '0'
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.cursorcolumn = false
vim.opt_local.cursorline = false

-- Keymaps
-- Remove escape mapping from fzf terminal buffer
vim.keymap.del('t', '<esc>', { buffer = true })
