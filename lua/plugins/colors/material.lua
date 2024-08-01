-- material.nvim | Material colorscheme for NeoVim written in Lua
-- https://github.com/marko-cerovac/material.nvim

---@type LazyPluginSpec
return {
  "marko-cerovac/material.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.material_style = "darker"
  end,
  opts = function()
    local c = require("material.colors")
    return {
      lualine_style = "stealth",
      high_visibility = {
        darker = false,
        lighter = true,
      },
      disable = {
        background = true,
      },
      plugins = {
        "dap",
        "dashboard",
        "gitsigns",
        "hop",
        "indent-blankline",
        "neogit",
        "nvim-cmp",
        "nvim-navic",
        "nvim-tree",
        "nvim-web-devicons",
        "telescope",
        "trouble",
        "which-key",
      },
      -- Overwrite default colors with your own
      custom_colors = {},
      -- Overwrite highlights with your own
      custom_highlights = {
        DiffChange = { fg = c.yellow },
        GitSignsChange = { fg = c.darkyellow },
        MsgSeparator = { link = "VertSplit" },
        TSField = { link = "TSVariable" },
        WhichKeyFloat = { link = "StatusLineNC" },
      },
    }
  end,
}
