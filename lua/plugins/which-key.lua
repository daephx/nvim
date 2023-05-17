-- Which-key | Configurations for plugin WhichKey.nvim
-- https://github.com/folke/which-key.nvim

return {
  "folke/which-key.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    operators = { gc = "Comments" },
    key_labels = {
      ["<bs>"] = "BS",
      ["<cr>"] = "RET",
      ["<space>"] = "SPC",
      ["<tab>"] = "TAB",
    },
    window = {
      border = { "", "_", "", "", "", "", "", "" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      mode = { "n", "v" },
      ["["] = { name = "+Prev" },
      ["]"] = { name = "+Next" },
      ["g"] = { name = "+Goto" },
      ["g'"] = { name = "+Marks" },
      ["g`"] = { name = "+Marks" },
      ["gc"] = { name = "+Comment" },
      ["<leader>b"] = { name = "+Buffer" },
      ["<leader>d"] = { name = "+Debug" },
      ["<leader>f"] = { name = "+Fuzzy" },
      ["<leader>g"] = { name = "+Git" },
      ["<leader>p"] = { name = "+Plugins" },
      ["<leader>P"] = { name = "+Projects" },
      ["<leader>s"] = { name = "+Sessions" },
      ["<leader>t"] = { name = "+Terminal" },
      ["<leader>z"] = { name = "+Notes" },
    })
  end,
}
