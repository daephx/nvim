-- Define colors for builtin colorscheme: zaibatsu

---@type config.Highlights
return {
  CursorLineFold = { link = "FoldColumn" },
  CursorLineNr = { ctermfg = 227, fg = "#ffff5f", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  EndOfBuffer = { ctermfg = 147, fg = "#afafff" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 235, bg = "#261e34" },
  LineNr = { ctermfg = 240, fg = "#4d4d70" },
  MatchParen = { ctermbg = 236, bg = "#4d4d70" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 103, fg = "#6e5795" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = 60, bg = "#52416f" },
  PmenuSel = { ctermbg = 237, bg = "#362b49" },
  StatusLine = { ctermfg = 16, fg = "White" },
  StatusLineNC = { ctermbg = 16, ctermfg = 243, bg = "Grey15", fg = "White" },
  TabLine = { link = "StatusLine" },
  TabLineFill = { link = "StatusLine" },
  Title = { link = "Special" },
  Underlined = { ctermfg = 118, fg = "#87ff00", underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermbg = 24, bg = "#3a5277" },
  WinSeparator = { ctermfg = 53, fg = "#362b49" },

  -- Diagnostics
  DiagnosticInfo = { ctermfg = 39, fg = "#00afff" },
  DiagnosticOk = { ctermfg = 118, fg = "#87ff00" },
  DiagnosticWarn = { ctermfg = 214, fg = "#ffaf00" },
  Error = { ctermfg = 205, fg = "#ff5faf" },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },

  -- Search
  CurSearch = { link = "IncSearch" },
  IncSearch = { ctermbg = 214, ctermfg = 16, bg = "#ffaf00", fg = "Black" },
  Search = { ctermbg = 123, ctermfg = 16, bg = "#87ffff", fg = "Black" },

  -- Git
  Added = { ctermfg = 118, fg = "#87ff00" },
  Removed = { ctermfg = 205, fg = "#ff5faf" },
  Changed = { ctermfg = 14, fg = "#8787ff" },

  -- Diff
  DiffAdd = { ctermfg = 118, ctermbg = 237, fg = "none", bg = "#1a3100" },
  DiffChange = { ctermfg = 147, ctermbg = 237, fg = "none", bg = "#2a2a50" },
  DiffDelete = { ctermfg = 205, ctermbg = 237, fg = "#ff5faf", bg = "#652545" },
  DiffText = { ctermfg = 189, ctermbg = 237, fg = "none", bg = "#3e3e76" },

  -- Dap
  DapStoppedLine = { bg = "#514f27" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 39, fg = "#00afff", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 123, fg = "#87ffff", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 118, fg = "#87ff00", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "#ffaf00", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 219, fg = "#ffafff", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 205, fg = "#ff5faf", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 105, fg = "#8787ff", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 227, fg = "#ffff5f", nocombine = true },

  -- Neogit
  NeogitDiffAdd = { ctermfg = 118, ctermbg = 237, fg = "#87ff00", bg = "#1a3100" },
  NeogitDiffChange = { ctermfg = 147, ctermbg = 237, fg = "#8787ff", bg = "#2a2a50" },
  NeogitDiffDelete = { ctermfg = 205, ctermbg = 237, fg = "#ff5faf", bg = "#652545" },
}
