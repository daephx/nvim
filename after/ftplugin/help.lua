-- ftplugin: help.txt files

-- Settings
vim.opt_local.expandtab = true
vim.opt_local.textwidth = 78
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.spell = false
vim.opt_local.bufhidden = ''
vim.opt_local.signcolumn = 'yes:1'
vim.opt_local.colorcolumn = '0'
vim.opt_local.cursorline = false
vim.opt_local.formatoptions = { c = false }
vim.opt_local.iskeyword:append(',:,#,-')

-- Mappings
local opts = { buffer = true, remap = false, silent = true }

-- Quickly close help window
vim.keymap.set('n', 'q', '<cmd>q<cr>', opts)

-- Jump to specific subjects by using tags
vim.keymap.set('n', '<cr>', '<c-]>', opts)
vim.keymap.set('n', '<bs>', '<c-T>', opts)
