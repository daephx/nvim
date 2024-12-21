-- neovim-ayu | Ayu theme for Neovim
-- https://github.com/Shatur/neovim-ayu
---@module "ayu"

---@type LazyPluginSpec
return {
  "Shatur/neovim-ayu",
  name = "ayu",
  lazy = false,
  priority = 1000,
  opts = {
    overrides = function()
      local c = require("ayu.colors")
      local overrides = {
        -- General
        Comment = { fg = c.comment },
        CursorLineNr = { fg = c.accent, bg = "none", bold = true },
        Error = { fg = c.error, bg = "none" },
        FloatBorder = { fg = "#394050" },
        FoldColumn = { fg = c.fg_idle, bg = "none" },
        Folded = { fg = c.fg_idle, bg = "#2a2a2a" },
        IncSearch = { fg = c.bg, bg = c.special },
        LineNr = { fg = c.fg_idle },
        MsgSeparator = { link = "WinSeparator" },
        NonText = { fg = c.guide_active },
        Normal = { bg = "none" },
        NormalFloat = { link = "Normal" },
        PmenuSel = { fg = "none", bg = c.selection_inactive, reverse = false },
        SignColumn = { bg = "none" },
        StatusLine = { bg = "none" },
        Underlined = { fg = c.accent, underline = true },
        VertSplit = { link = "WinSeparator" },
        Visual = { bg = c.selection_bg },
        WinBar = { link = "Normal" },
        WinBarNC = { link = "Normal" },
        WinSeparator = { fg = c.guide_normal, bg = "none" },

        -- Diff
        DiffDelete = { fg = c.vcs_removed, bg = "#321619" },

        -- LSP
        ["@lsp.mod.global.lua"] = { fg = c.markup },

        -- Treesitter Rainbow
        RainbowDelimiterBlue = { fg = c.vcs_modified },
        RainbowDelimiterCyan = { fg = c.regexp },
        RainbowDelimiterGreen = { fg = c.vcs_added },
        RainbowDelimiterOrange = { fg = c.operator },
        RainbowDelimiterRed = { fg = c.vcs_removed },
        RainbowDelimiterViolet = { fg = c.lsp_parameter },
        RainbowDelimiterYellow = { fg = c.special },
      }

      -- Conditionally override colors for `h background
      if vim.o.background == "light" then
        overrides.DiffDelete = { fg = c.vcs_removed, bg = "#ebecec" }
        overrides.Folded = { fg = c.fg_idle, bg = "#c2c2c2" }
        overrides.Normal = nil
      else
        vim.g.terminal_color_8 = "#394050"
        vim.g.terminal_color_15 = "#fffcf2"
      end

      return overrides
    end,
  },
}
