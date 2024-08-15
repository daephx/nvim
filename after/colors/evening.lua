-- Define colors for builtin colorscheme: evening

local M = {}

M.colors = {
  LineNr = { fg = "Grey49" },
  CursorLine = { bg = "Gray15" },
  CursorLineNr = { ctermfg = 3, bg = "none", fg = "Yellow", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  EndOfBuffer = { ctermfg = 153, ctermbg = "none", fg = "LightSkyBlue1", bg = "none" },
  FloatBorder = { link = "VertSplit" },
  NonText = { ctermfg = 153, ctermbg = "none", fg = "LightSkyBlue1", bg = "none" },
  NormalFloat = { ctermbg = "none", bg = "none" },
  Pmenu = { link = "NormalFloat" },
  StatusLine = { ctermbg = "none", ctermfg = 234, bg = "none", fg = "Grey62" },
  StatusLineNC = { ctermfg = 234, ctermbg = 243, bg = "Grey46", fg = "Grey11" },
  Title = { link = "Define" },
  WinSeparator = { ctermbg = "none", ctermfg = 243, bg = "none", fg = "Grey46" },
  Visual = { ctermfg = 231, ctermbg = 246, bg = "Grey46" },

  -- Diff
  DiffAdd = { ctermbg = 232, ctermfg = 40, bg = "#0a300a" },
  DiffChange = { ctermbg = 232, ctermfg = 75, bg = "#002a4c" },
  DiffDelete = { ctermbg = 232, ctermfg = 196, fg = "Red" },
  DiffText = { ctermbg = 238, bg = "Grey27" },

  Added = { ctermfg = 40, fg = "Green3" },
  Changed = { ctermfg = 75, fg = "SteelBlue2" },
  Removed = { ctermfg = 196, fg = "Red" },
}

return M
