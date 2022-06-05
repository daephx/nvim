-- after/ftplugin: gitcommit

-- Options
vim.opt_local.bufhidden = 'delete'
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = 'yes:1'

vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = '73' -- ,51

vim.opt_local.formatoptions = { c = false }

vim.opt_local.spell = true
vim.opt_local.spellcapcheck = false
vim.opt_local.iskeyword:append('-')
