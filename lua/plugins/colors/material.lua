-- material.nvim | Material colorscheme for NeoVim written in Lua
-- https://github.com/marko-cerovac/material.nvim
---@module "material

---@type LazySpec
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
        "nvim-web-devicons",
        "telescope",
        "trouble",
        "which-key",
      },
      -- Overwrite default colors with your own
      custom_colors = {},
      -- Overwrite highlights with your own
      custom_highlights = {
        CursorLine = { bg = "Grey15" },
        FoldColumn = { link = "NonText" },
        Folded = { bg = "#311d00" },
        MsgSeparator = { link = "WinSeparator" },
        StatusLine = { bg = "none" },
        VertSplit = { link = "WinSeparator" },
        WinBar = { bg = "none" },
        WinBarNC = { bg = "none" },

        -- Search
        CurSearch = { link = "IncSearch" },
        IncSearch = { fg = "black", bg = "#ffcb6b", bold = true },
        Search = { fg = "black", bg = "#6bc3ff" },

        -- Diff
        DiffAdd = { bg = "#2c351e" },
        DiffChange = { bg = "#1a2438" },
        DiffDelete = { fg = c.git.removed, bg = "#5c272b" },
        DiffText = { bg = "#263553" },

        -- Neogit
        NeogitDiffAdd = { fg = c.git.added, bg = "#2c351e" },
        NeogitDiffChange = { fg = c.git.modified, bg = "#1a2438" },
        NeogitDiffDelete = { fg = c.git.removed, bg = "#5c272b" },
        NeogitDiffText = { bg = "#263553" },

        -- Treesitter
        TSField = { link = "TSVariable" },
        ["@property"] = { link = "Identifier" },
        ["@string.special.url"] = { fg = c.editor.link, underline = true },

        -- WhichKey
        WhichKeyFloat = { link = "StatusLineNC" },
        WhichKeySeparator = { link = "WinSeparator" },
      },
    }
  end,
}
