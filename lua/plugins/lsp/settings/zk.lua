-- zk-nvim | Neovim extension for zk
-- https://github.com/mickael-menu/zk-nvim
local zk_ok, zk = pcall(require, "zk")
if not zk_ok then
  return
end

zk.setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "telescope",
})

--- Keymaps ---

local util = require("config.util")
util.register_keymaps({ remap = false, silent = true }, {
  { "n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { desc = "new note" } },
  { "n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { desc = "show backlinks" } },
  { "n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = "show links" } },
  { "n", "<leader>zf", "<Cmd>ZkNotes<CR>", { desc = "show notes" } },
})
