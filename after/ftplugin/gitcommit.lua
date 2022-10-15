-- after/ftplugin/gitcommit

vim.opt_local.spell = true
vim.opt_local.spellcapcheck = ''

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.bufhidden = 'delete'
vim.opt_local.signcolumn = 'yes:1'

vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = '+1'
vim.opt_local.iskeyword:append('-')

vim.opt_local.formatoptions = {
  c = false, -- Auto-wrap comments using 'textwidth'
  t = true, -- Auto-wrap text using 'textwidth'
  l = true, -- Long lines are not broken in insert mode
}
