-- Which-key | Configurations for plugin WhichKey.nvim
-- https://github.com/folke/which-key.nvim

---@type LazyPluginSpec
return {
  "folke/which-key.nvim",
  event = { "VeryLazy" },
  ---@class wk.Opts
  opts = {
    preset = "classic",
    icons = { mappings = false },
    win = {
      row = math.huge,
      border = { "─", "─", "─", " ", "─", "", "", " " },
    },
    replace = {
      key = {
        { "<BS>", "BS" },
        { "<CR>", "RET" },
        { "<Esc>", "ESC" },
        { "<Space>", "SPC" },
        { "<Tab>", "TAB" },
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
      { "<leader>P", group = "Projects" },
      { "<leader>b", group = "Buffer" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>p", group = "Plugins" },
      { "<leader>s", group = "Sessions" },
      { "<leader>t", group = "Terminal" },
      { "<leader>z", group = "Notes" },
    })
  end,
}
