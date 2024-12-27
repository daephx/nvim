-- Define colors for builtin colorscheme: sorbet

---@type config.Highlights
return {
  CursorLine = { ctermbg = 237, bg = "#2f3347" },
  CursorLineNr = { ctermfg = 179, fg = "#d7af5f", bold = true },
  FloatBorder = { link = "WinSeparator" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 60, fg = "#7076aa" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = 236, bg = "#2e2e30" },
  PmenuSel = { ctermfg = 15, ctermbg = 60, fg = "White", bg = "MediumPurple4" },
  SpellCap = { link = "SpellBad" },
  Statement = { ctermfg = 177, fg = "Violet" },
  StatusLine = { ctermbg = "none", ctermfg = 8, fg = "Grey" },
  StatusLineNC = { ctermfg = 60, ctermbg = 16, fg = "MediumPurple4", bg = "Grey0" },
  Title = { ctermfg = 73, fg = "#5fafaf" },
  Underlined = { ctermfg = 73, fg = "CadetBlue", underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermbg = 94, bg = "#523c18" },
  WinSeparator = { ctermfg = 60, fg = "#5f5f87" },

  -- Diagnostics
  DiagnosticError = { ctermfg = 203, fg = "#d75f5f" },
  DiagnosticWarn = { ctermfg = 214, fg = "#d7af5f" },
  Error = { ctermfg = 203, fg = "#d75f5f", bold = true },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },
  WarningMsg = { ctermfg = 214, fg = "#d7af5f" },

  -- Search
  CurSearch = { link = "IncSearch" },
  IncSearch = { ctermbg = 214, ctermfg = 16, bg = "#d7af5f", fg = "Black" },
  Search = { ctermbg = 39, ctermfg = 16, bg = "#5fafaf", fg = "Black" },

  -- Git
  Added = { ctermfg = 113, fg = "#87d75f" },
  Changed = { ctermfg = 110, fg = "#87afd7" },
  Removed = { ctermfg = 167, fg = "#d75f5f" },

  -- Diff
  DiffAdd = { ctermfg = 16, ctermbg = 35, fg = "none", bg = "#253a1a" },
  DiffChange = { ctermfg = 16, ctermbg = 111, fg = "none", bg = "#202a3e" },
  DiffDelete = { ctermfg = 167, ctermbg = 52, fg = "#d75f5f", bg = "#301414" },
  DiffText = { ctermfg = 16, ctermbg = 213, fg = "none", bg = "#3a4772" },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 113, bg = "#253a1a", fg = "#87d75f" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 110, bg = "#202a3e", fg = "#87afd7" },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 167, bg = "#301414", fg = "#d75f5f" },
  NeogitDiffText = { ctermbg = 213, bg = "#3a4772" },
  NeogitHunkHeader = { ctermbg = 60, bg = "#533f7d" },
  NeogitCommitViewHeader = { ctermbg = 60, bg = "#533f7d" },
  NeogitActiveItem = { link = "Visual" },
  NeogitDiffContextHighlight = { fg = "Red" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 110, fg = "#87afd7", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 73, fg = "#5fafaf", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 113, fg = "#87d75f", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 179, fg = "#cc9b6e", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 170, fg = "#c46cc4", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 167, fg = "#d75f5f", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 140, fg = "#af87d7", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 179, fg = "#d7af5f", nocombine = true },
}
