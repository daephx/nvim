-- zk-nvim | Neovim extension for zk
-- https://github.com/mickael-menu/zk-nvim
local zk_ok, zk = pcall(require, 'zk')
if not zk_ok then
  return
end

zk.setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = 'telescope',
})

--- Keymaps ---

local defaults = { remap = false, silent = true }
local function map(mode, k, cb, opts)
  local options = vim.tbl_extend('force', defaults, opts)
  vim.keymap.set(mode, k, cb, options)
end

-- Define zk keymaps
map('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { desc = 'new note' })
map('n', '<leader>Zb', '<Cmd>ZkBacklinks<CR>', { desc = 'show backlinks' })
map('n', '<leader>Zl', '<Cmd>ZkLinks<CR>', { desc = 'show links' })
map('n', '<leader>Zf', '<Cmd>ZkNotes<CR>', { desc = 'show notes' })
