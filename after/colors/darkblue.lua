-- Define colors for builtin colorscheme: darkblue

---@type config.Highlights
return {
  CurSearch = { link = "IncSearch" },
  CursorLine = { ctermbg = 236, bg = "Grey19" },
  CursorLineFold = { ctermbg = "none", bg = "none" },
  CursorLineNr = { ctermfg = 3, fg = "Yellow" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  Folded = { ctermbg = 234, bg = "Grey11" },
  IncSearch = { ctermfg = 40, bg = "Green" },
  LineNr = { ctermfg = 239, fg = "Grey30" },
  MatchParen = { ctermbg = 241, bg = "Grey39" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 27, fg = "DodgerBlue3" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = 105, bg = "#00004d" },
  PmenuSel = { ctermbg = 59, bg = "Grey32" },
  Statement = { ctermfg = 177, fg = "Violet" },
  StatusLine = { ctermfg = 233, ctermbg = 18, fg = "Grey30", bg = "#000040" },
  StatusLineNC = { ctermbg = 18, ctermfg = 239, fg = "Grey30", bg = "DarkBlue" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermbg = 105, bg = "#000080" },
  WinSeparator = { ctermfg = 239, fg = "Grey30" },

  -- Diagnostics
  DiagnosticError = { link = "Error" },
  DiagnosticInfo = { ctermfg = 75, fg = "SteelBlue2" },
  DiagnosticOk = { ctermfg = 40, fg = "Green3" },
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
  DiffAdd = { ctermbg = 4, ctermfg = 40, bg = "#0a300a" },
  DiffChange = { ctermbg = 5, ctermfg = 75, bg = "#002a4c" },
  DiffDelete = { ctermbg = 131, ctermfg = 196, fg = "#bb4c4c" },
  DiffText = { ctermbg = 23, bg = "#005498" },

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
