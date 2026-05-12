-- Define colors for builtin colorscheme: ron

---@type config.Highlights
return {
  CursorLine = { bg = "Gray15" },
  CursorLineNr = { ctermfg = 226, bg = "Gray15", fg = "Yellow", bold = true },
  EndOfBuffer = { ctermfg = 226, fg = "Yellow" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 234, bg = "Gray12" },
  LineNr = { ctermfg = 242, fg = "Gray42" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { fg = "Gray25" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  SignColumn = { ctermbg = "none", bg = "none" },
  StatusLine = { ctermfg = 242, bg = "Blue", fg = "Gray2" },
  Title = { ctermfg = 145, fg = "Yellow" },
  WinSeparator = { ctermfg = 238, fg = "Gray32" },
  Visual = { ctermbg = 18, bg = "Gray24" },
  VertSplit = { link = "WinSeparator" },

  -- Diff
  DiffAdd = { ctermbg = "none", bg = "none" },
  DiffChange = { ctermbg = "none", bg = "none" },
  DiffDelete = { ctermbg = "none", bg = "none" },
  DiffText = { ctermbg = "none", bg = "none" },
}
