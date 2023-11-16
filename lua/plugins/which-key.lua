-- Which-key | Configurations for plugin WhichKey.nvim
-- https://github.com/folke/which-key.nvim

return {
  "folke/which-key.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    window = { border = { "", "_", "", "", "", "", "", "" } },
    operators = { gc = "Comments" },
    key_labels = {
      ["<bs>"] = "BS",
      ["<cr>"] = "RET",
      ["<space>"] = "SPC",
      ["<tab>"] = "TAB",
    },
    defaults = {
      mode = { "n", "v" },
      ["["] = { name = "+prev" },
      ["]"] = { name = "+next" },
      ["g"] = { name = "+goto" },
      ["g'"] = { name = "+marks" },
      ["g`"] = { name = "+marks" },
      ["gc"] = { name = "+comment" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>f"] = { name = "+find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>p"] = { name = "+plugins" },
      ["<leader>P"] = { name = "+projects" },
      ["<leader>s"] = { name = "+sessions" },
      ["<leader>t"] = { name = "+terminal" },
      ["<leader>z"] = { name = "+notes" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
