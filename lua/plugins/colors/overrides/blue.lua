-- Define colors for builtin colorscheme: blue

---@type config.Highlights
return {
  CursorLine = { ctermbg = 25, bg = "#003562" },
  CursorLineFold = { link = "FoldColumn" },
  CursorLineNr = { ctermfg = 87, fg = "#5fffff", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  EndOfBuffer = { ctermfg = 220, fg = "#ffd700" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 234, bg = "Grey11" },
  LineNr = { ctermfg = 59, fg = "Grey37" },
  MatchParen = { bg = "Grey37" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  PmenuSel = { ctermbg = 231, bg = "Turquoise4" },
  Statement = { ctermfg = 177, fg = "Violet" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermfg = 231, ctermbg = 30, fg = "none", bg = "Turquoise4" },
  WinSeparator = { ctermfg = 30, fg = "#008787" },

  -- Search
  CurSearch = { link = "IncSearch" },

  -- Diagnostics
  DiagnosticError = { link = "Error" },
  DiagnosticWarn = { link = "WarningMsg" },
  Error = { ctermfg = 196, fg = "#bb4c4c" },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },
  WarningMsg = { ctermfg = 209, fg = "#ff7f50" },

  -- Git
  Added = { ctermfg = 40, fg = "Green3" },
  Changed = { ctermfg = 75, fg = "SteelBlue2" },
  Removed = { ctermfg = 196, fg = "Red" },

  -- Diff
  DiffAdd = { ctermbg = 4, ctermfg = 40, fg = "none", bg = "#0a300a" },
  DiffChange = { ctermbg = 5, ctermfg = 75, fg = "none", bg = "#002a4c" },
  DiffDelete = { ctermbg = 131, ctermfg = 196, fg = "#bb4c4c", bg = "#301414" },
  DiffText = { ctermfg = 16, ctermbg = 23, fg = "none", bg = "#005498" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 5, fg = "Blue", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 6, fg = "Cyan", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 2, fg = "Green", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "Orange", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 218, fg = "Pink", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 1, fg = "Red", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 5, fg = "Magenta", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 3, fg = "Yellow", nocombine = true },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 40, bg = "#0a300a", fg = "Green3" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 75, bg = "#002a4c" },
  NeogitDiffDelete = { ctermbg = 234, ctermfg = 131, fg = "#bb4c4c", bg = "#301414" },
}
