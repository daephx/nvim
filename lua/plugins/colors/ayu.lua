-- neovim-ayu | Ayu theme for Neovim
-- https://github.com/Shatur/neovim-ayu
---@module "ayu"

---@type LazySpec
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
        FloatBorder = { fg = c.guide_inactive },
        FoldColumn = { fg = c.fg_idle, bg = "none" },
        Folded = { fg = "none", bg = c.guide_normal },
        IncSearch = { fg = c.bg, bg = c.special },
        LineNr = { fg = c.gutter_normal },
        MsgSeparator = { link = "WinSeparator" },
        NonText = { fg = c.guide_active },
        Normal = { bg = "none" },
        NormalFloat = { link = "Normal" },
        PmenuSel = { fg = "none", bg = c.selection_bg, reverse = false },
        SignColumn = { bg = "none" },
        StatusLine = { bg = "none" },
        Underlined = { fg = c.accent, underline = true },
        VertSplit = { link = "WinSeparator" },
        Visual = { bg = c.selection_bg },
        WinBar = { link = "Normal" },
        WinBarNC = { link = "Normal" },
        WinSeparator = { fg = c.guide_normal, bg = "none" },

        -- Diff
        DiffDelete = { fg = c.vcs_removed, bg = c.vcs_removed_bg },

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

        -- DAP
        DapStoppedLine = { bg = c.vcs_added_bg },

        -- Telescope
        TelescopePromptBorder = { link = "FloatBorder" },
        TelescopeSelection = { link = "PmenuSel" },
      }

      -- Conditionally override colors for `h background
      if vim.o.background == "light" then
        overrides.Normal = nil
      else
        vim.g.terminal_color_8 = "#394050"
        vim.g.terminal_color_15 = "#fffcf2"
      end

      return overrides
    end,
  },
}
