-- after/ftplugin: markdown

-- Options
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.wrap = false
vim.opt_local.textwidth = 80
vim.opt_local.foldmethod = 'syntax'
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.opt_local.filetype = 'markdown'

-- Allow for folding markdown headings
vim.g.markdown_folding = 1
