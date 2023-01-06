-- after/ftplugin/json

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4

vim.opt_local.commentstring = "//%s"

-- Add comment highlighting
vim.cmd("syntax match Comment +\\/\\/.\\+$+")
