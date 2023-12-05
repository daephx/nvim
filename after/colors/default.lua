local M = {}

M.colors = {
  ColorColumn = { bg = "NvimDarkBlue" },
  Constant = { fg = "NvimLightRed" },
  CursorLineNr = { ctermfg = 222, fg = "NvimLightYellow" },
  FloatBorder = { link = "WinSeparator" },
  NonText = { ctermfg = 239, fg = "Gray15" },
  Normal = { ctermfg = 253, bg = "none", fg = "NvimLightGrey2" },
  PmenuSel = { bg = "NvimDarkGrey3" },
  Statement = { fg = "NvimLightMagenta" },
  StatusLine = { bg = "none" },
  Type = { fg = "NvimLightCyan" },
  WinSeparator = { ctermfg = 236, fg = "NvimDarkGrey3" },

  -- Git
  GitSignsAdd = { ctermfg = 157, fg = "NvimLightGreen", bold = true },
  GitSignsChange = { ctermfg = 222, fg = "NvimLightYellow", bold = true },
  GitSignsDelete = { ctermfg = 217, fg = "NvimLightRed", bold = true },

  -- LSP
  ["@lsp.mod.defaultLibrary.lua"] = { link = "@namespace" },

  -- Treesitter
  ["@variable"] = { link = "Identifier" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { fg = "NvimLightBlue", nocombine = true },
  RainbowDelimiterCyan = { fg = "NvimLightCyan", nocombine = true },
  RainbowDelimiterGreen = { fg = "NvimLightGreen", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 221, fg = "LightGoldenrod2", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 210, fg = "LightCoral", nocombine = true },
  RainbowDelimiterRed = { fg = "NvimLightRed", nocombine = true },
  RainbowDelimiterViolet = { fg = "NvimLightMagenta", nocombine = true },
  RainbowDelimiterYellow = { fg = "NvimLightYellow", nocombine = true },

  -- Dashboard
  DashboardHeader = { link = "Special" },
  DashboardDesc = { link = "String" },
  DashboardFooter = { link = "Comment" },
  DashboardIcon = { link = "String" },
  DashboardShortCut = { link = "Keyword" },
}

-- Neovim 0.10+ introduces a new default colorscheme.
-- In older versions, `default` refers to the old scheme, now renamed `vim` in newer versions.
-- Support older versions by loading the appropriate color definitions.
if vim.fn.has("nvim-0.10") == 0 then
  M.colors = require("after.colors.vim")
end

-- Don't modify Normal if background is set to light mode.
if vim.o.background == "light" then
  M.colors["Normal"] = nil
end

return M
