-- Define colors for builtin colorscheme: koehler

local M = {}

M.colors = {
  CursorLine = { bg = "Gray15" },
  CursorLineNr = { bg = "Gray15", fg = "Yellow", bold = true },
  Folded = { bg = "Gray12" },
  IncSearch = { ctermbg = 52, bg = "DarkRed" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  Statement = { fg = "Violet" },
  StatusLine = { ctermfg = 234, bg = "Gray24", fg = "Grey11" },
  StatusLineNC = { ctermfg = 234, ctermbg = 243, bg = "Grey46", fg = "Grey11" },
  WinSeparator = { fg = "Gray32" },
  Visual = { ctermbg = 241, bg = "Grey39" },
}

return M
