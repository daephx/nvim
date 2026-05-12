-- Define colors for builtin colorscheme: morning

---@type config.Highlights
return {
  Constant = { ctermbg = "none", ctermfg = 201, bg = "none", fg = "#ff00ff" },
  CursorLinrNr = { bg = "none" },
  EndOfBuffer = { ctermbg = 252, ctermfg = 21, bg = "none", fg = "#0000ff", bold = true },
  NonText = { bg = "none" },
  Normal = { ctermfg = 16, ctermbg = 254, fg = "Black", bg = "#e4e4e4" },
  NormalBorder = { link = "VertSplit" },
  NormalFloat = { link = "Normal" },
  StatusLineNC = { bg = "Gray4" },
  WinSeparator = { bg = "none" },
}
