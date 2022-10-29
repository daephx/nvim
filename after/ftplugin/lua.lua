-- after/ftplugin/lua

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

vim.opt_local.formatoptions = {
  o = false, -- Insert comment leader after hitting 'o'
  r = false, -- Insert comment leader after hitting <Enter>
}
