-- Define colors for builtin colorscheme: zaibatsu

---@type config.Highlights
return {
  CursorLineNr = { ctermfg = 227, fg = "#ffff5f", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  EndOfBuffer = { ctermfg = 147, fg = "#afafff" },
  Error = { ctermbg = 160, ctermfg = 9, bg = "#d70000", fg = "#ff5faf" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 235, bg = "#261e34" },
  LineNr = { ctermfg = 240, fg = "#4d4d70" },
  MatchParen = { ctermbg = 236, bg = "#4d4d70" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 103, fg = "#878092" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = 60, bg = "#52416f" },
  PmenuSel = { ctermbg = 237, bg = "#362b49" },
  StatusLine = { ctermfg = 16, fg = "White" },
  StatusLineNC = { ctermbg = 16, ctermfg = 243, bg = "Grey15", fg = "White" },
  Title = { link = "Special" },
  WinSeparator = { ctermfg = 53, fg = "#362b49" },
  Visual = { ctermbg = 24, bg = "#283851" },
  VertSplit = { link = "WinSeparator" },

  -- Search
  CurSearch = { link = "IncSearch" },
  IncSearch = { ctermbg = 214, ctermfg = 16, bg = "#ffaf00", fg = "Black" },
  Search = { ctermbg = 123, ctermfg = 16, bg = "#87ffff", fg = "Black" },

  -- Git
  Added = { ctermfg = 10, fg = "#00d700" },
  Removed = { ctermfg = 9, fg = "#ff5faf" },
  Changed = { ctermfg = 14, fg = "#8787ff" },

  -- Diff
  DiffAdd = { ctermfg = 118, ctermbg = 237, fg = "#87ff00", bg = "#362b49" },
  DiffChange = { ctermfg = 147, ctermbg = 237, fg = "#8787ff", bg = "#362b49" },
  DiffDelete = { ctermfg = 205, ctermbg = 237, fg = "#ff5faf" },
  DiffText = { ctermfg = 189, ctermbg = 237, fg = "#d7d5db", bg = "#362b49" },

  -- Dap
  DapStoppedLine = { bg = "#514f27" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 39, fg = "#00afff", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 123, fg = "#87ffff", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 118, fg = "#87ff00", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "#ffaf00", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 219, fg = "#ffafff", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 205, fg = "#ff5faf", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 14, fg = "#8787ff", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 227, fg = "#ffff5f", nocombine = true },
}
