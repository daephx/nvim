-- ftplugin: json

-- Settings
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- Syntax
-- Add comment highlighting
vim.cmd('syntax match Comment +\\/\\/.\\+$+')
