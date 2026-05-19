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
        "gitsigns",
        "hop",
        "neogit",
        "nvim-cmp",
        "nvim-navic",
        "nvim-web-devicons",
        "rainbow-delimiters",
        "trouble",
        "which-key",
      },
      -- Custom colors must be a function that takes in the default colors table as
      -- a parameter, and then modifies them.
      -- To see the available colors, see lua/material/colors/init.lua
      custom_colors = function(colors)
        colors.syntax.comments = "#848484"
      end,
      -- Overwrite highlights with your own
      custom_highlights = {
        ColorColumn = { bg = "#222222" },
        CursorLine = { bg = c.editor.contrast },
        FloatBorder = { fg = c.main.gray },
        FoldColumn = { link = "NonText" },
        Folded = { bg = "#311d00" },
        MatchParen = { reverse = true },
        MsgSeparator = { link = "WinSeparator" },
        PmenuThumb = { bg = c.main.gray },
        StatusLine = { bg = "none", fg = "black" },
        StatusLineTerm = { link = "StatusLine" },
        TabLineSel = { fg = c.main.black, bg = c.main.orange },
        VertSplit = { link = "WinSeparator" },
        WinBar = { bg = "none" },
        WinBarNC = { bg = "none" },

        -- Search
        CurSearch = { link = "IncSearch" },
        IncSearch = { fg = "black", bg = c.main.yellow, bold = true },
        Search = { fg = "black", bg = c.main.blue },

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

        NeogitHunkHeader = { fg = c.main.purple, bg = "#3f3f3f" },
        NeogitWinSeparator = { link = "WinSeparator" },
        NeogitNormalFloat = { link = "NormalFloat" },

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
