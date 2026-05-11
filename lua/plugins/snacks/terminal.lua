-- Configuration for snacks.nvim terminal module (toggle terminal)
-- Main configuration is in lua/plugins/snacks/init.lua
-- https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md

---@type LazySpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<c-\\>", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
    { "<leader>gG", function() Snacks.lazygit() end, mode = { "n" }, desc = "Lazygit" },
  },
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    terminal = {
      win = {
        style = "float",
        border = vim.o.winborder,
      },
    },
    lazygit = {
      -- Support lazygit to use the entire screen.
      -- https://github.com/folke/snacks.nvim/issues/719
      win = {
        width = 0,
        height = 0,
      },
    },
  },
}
