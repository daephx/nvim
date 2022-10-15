-- after/ftplugin/fugitive

--- Options ---

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.cursorline = true
vim.opt_local.cursorlineopt = 'both'
vim.opt_local.colorcolumn = '0'
vim.opt_local.signcolumn = 'yes:1'
vim.opt_local.foldmethod = 'syntax'

--- Keymaps ---

local opts = { buffer = true, remap = true, silent = true }

vim.keymap.set('n', '<tab>', '=', opts)
vim.keymap.set('n', 'q', 'gq', opts)

--- Autocmds ---

-- vim.api.nvim_create_augroup('FugitiveIndex', {})
-- vim.api.nvim_create_autocmd('User', {
--   group = 'FugitiveIndex',
--   pattern = 'FugitiveIndex',
--   callback = function()
--     vim.opt_local.scrolloff = 80
--   end,
-- })
