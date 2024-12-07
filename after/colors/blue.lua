-- Define colors for builtin colorscheme: blue

---@type config.Highlights
return {
  CurSearch = { link = "IncSearch" },
  CursorLine = { ctermbg = 25, bg = "#003562" },
  CursorLineNr = { ctermfg = 87, fg = "#5fffff", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  EndOfBuffer = { ctermfg = 220, fg = "#ffd700" },
  Error = { ctermfg = 209, fg = "#ff7f50" },
  ErrorMsg = { link = "Error" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { bg = "Grey12" },
  IncSearch = { ctermfg = 40, bg = "Green" },
  LineNr = { fg = "Grey37" },
  MatchParen = { bg = "Grey37" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  PmenuSel = { ctermbg = 231, bg = "Turquoise4" },
  Statement = { fg = "Violet" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermfg = 231, ctermbg = 30, bg = "Turquoise4" },

  -- Diff
  DiffAdd = { ctermfg = 231, ctermbg = 65, bg = "#293a29", fg = "none" },
  DiffChange = { ctermfg = 231, ctermbg = 67, bg = "#354b62", fg = "none" },
  DiffDelete = { ctermfg = 231, ctermbg = 133, bg = "#623562", fg = "#af5faf" },
  DiffText = { ctermfg = 16, ctermbg = 251, bg = "#415b7b", fg = "none" },
}
