-- after/ftplugin/gitcommit

vim.opt_local.spell = true
vim.opt_local.spellcapcheck = ""

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.bufhidden = "delete"
vim.opt_local.signcolumn = "yes:1"

vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = "+1"
vim.opt_local.iskeyword:append("-")
vim.opt_local.commentstring = "#%s"

vim.opt_local.formatoptions = {
  c = false, -- Auto-wrap comments using 'textwidth'
  l = false, -- Auto-wrap long lines in insert mode
  q = true, -- Allow formatting of comments with "gq"
  t = true, -- Auto-wrap text using 'textwidth'
}
