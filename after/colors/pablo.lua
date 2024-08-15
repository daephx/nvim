-- Define colors for builtin colorscheme: pablo

local M = {}

M.colors = {
  CursorLine = { bg = "Gray15" },
  CursorLineNr = { ctermfg = 226, fg = "Yellow", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  EndOfBuffer = { ctermfg = 226, fg = "Yellow" },
  LineNr = { ctermfg = 242, fg = "Gray42" },
  NonText = { link = "Comment" },
  Normal = { ctermbg = "none", bg = "none" },
  Pmenu = { ctermbg = "none", bg = "none" },
  PmenuSel = { ctermbg = 20, bg = "Blue4" },
  SignColumn = { ctermbg = "none", bg = "none" },
  Special = { fg = "LightBlue" },
  StatusLineNC = { ctermfg = 242, bg = "Blue4", fg = "Gray2" },
  Title = { ctermfg = 145, fg = "Yellow" },
  WinSeparator = { ctermfg = 238, fg = "Gray32" },
}

return M
