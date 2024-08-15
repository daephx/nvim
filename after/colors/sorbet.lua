-- Define colors for builtin colorscheme: sorbet

local M = {}

M.colors = {
  CursorLine = { ctermbg = 237, bg = "#2f3347" },
  CursorLineNr = { fg = "#d7af5f", bold = true },
  Error = { ctermfg = 203, fg = "#ff5f5f", bold = true },
  ErrorMsg = { link = "Error" },
  FloatBorder = { link = "WinSeparator" },
  NonText = { ctermfg = 60, fg = "#575c84" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = 236, bg = "#2e2e30" },
  PmenuSel = { ctermfg = 15, ctermbg = 60, fg = "White", bg = "MediumPurple4" },
  Statement = { ctermfg = 177, fg = "Violet" },
  StatusLine = { ctermbg = "none", ctermfg = 8, fg = "Grey" },
  StatusLineNC = { ctermfg = 60, ctermbg = 16, fg = "MediumPurple4", bg = "Grey0", reverse = false },
  Underlined = { ctermfg = 73, fg = "#5fafaf", underline = true },
  Visual = { ctermbg = 94, bg = "#523c18" },

  -- Search
  CurSearch = { link = "IncSearch" },
  IncSearch = { ctermfg = 214, ctermbg = 16, fg = "#ffaf00", bg = "#000000" },
  Search = { ctermfg = 39, ctermbg = 16, fg = "#00afff", bg = "#000000" },

  -- Git
  Added = { ctermfg = 113, fg = "#87d75f" },
  Changed = { ctermfg = 110, fg = "#87afd7" },
  Removed = { ctermfg = 167, fg = "#d75f5f" },

  -- Diff
  DiffAdd = { ctermbg = 35, bg = "#004e2a" },
  DiffChange = { ctermbg = 111, bg = "#202a3e" },
  DiffDelete = { ctermbg = 52, ctermfg = 167, bg = "#301414", fg = "#d75f5f" },
  DiffText = { ctermbg = 213, bg = "#3a4772" },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 113, bg = "#004e2a", fg = "#87d75f" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 110, bg = "#202a3e", fg = "#87afd7" },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 167, bg = "#301414", fg = "#d75f5f" },
  NeogitDiffText = { ctermbg = 213, bg = "#3a4772" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { fg = "#87afd7", nocombine = true },
  RainbowDelimiterCyan = { fg = "#5fafaf", nocombine = true },
  RainbowDelimiterGreen = { fg = "#87d75f", nocombine = true },
  RainbowDelimiterOrange = { fg = "#cc9b6e", nocombine = true },
  RainbowDelimiterPink = { fg = "#c46cc4", nocombine = true },
  RainbowDelimiterRed = { fg = "#d75f5f", nocombine = true },
  RainbowDelimiterViolet = { fg = "#af87d7", nocombine = true },
  RainbowDelimiterYellow = { fg = "#d7af5f", nocombine = true },
}

return M
