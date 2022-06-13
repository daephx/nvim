-- after/ftplugin: git fugitive

--- Options ---

vim.opt_local.colorcolumn = '0'
vim.opt_local.cursorline = true
vim.opt_local.cursorlineopt = 'both'
vim.opt_local.foldmethod = 'syntax'
vim.opt_local.number = false
vim.opt_local.relativenumber = false

--- Keymaps ---

--- Autocmds ---

vim.api.nvim_create_augroup('FugitiveBuffer', {})
vim.api.nvim_create_autocmd('User', {
  desc = 'Apply setting to FugitiveIndex buffer',
  pattern = 'FugitiveIndex',
  group = 'FugitiveBuffer',
  callback = function()
    local opts = { buffer = 0, remap = false, silent = true }
    -- Fugitive status index
    vim.keymap.set('n', '<tab>', '=', opts)
    vim.keymap.set('n', '<q>', 'gq', opts)
  end,
})
