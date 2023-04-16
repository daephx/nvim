-- after/ftplugin/help

vim.opt_local.buflisted = false
vim.opt_local.expandtab = true
vim.opt_local.list = false
vim.opt_local.spell = false
vim.opt_local.bufhidden = "delete"
vim.opt_local.colorcolumn = "0"
vim.opt_local.signcolumn = "yes:1"
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.textwidth = 78

vim.opt_local.iskeyword:append({ ":", "#", "-" })

local opts = { buffer = true, remap = false, silent = true }

-- Jump to specific subjects by using tags
vim.keymap.set("n", "<CR>", "<c-]>", opts)
vim.keymap.set("n", "<BS>", "<c-T>", opts)
