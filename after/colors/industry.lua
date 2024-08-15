-- Define colors for builtin colorscheme: industry

local M = {}

M.colors = {
  CursorLine = { bg = "Gray15" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  CursorLinrNr = { ctermbg = "none", bg = "none" },
  FloatBorder = { link = "WinSeparator" },
  LineNr = { ctermfg = 240, fg = "Grey35" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  PmenuSel = { ctermbg = 4, ctermfg = 16, bg = "DarkYellow", fg = "Black" },
  Statement = { fg = "HotPink" },
  StatusLine = { ctermbg = 81, ctermfg = 16 },
  StatusLineNC = { ctermbg = 16, ctermfg = 243, bg = "Grey15", fg = "White" },
  WinSeparator = { ctermfg = 242, fg = "#6c6c6c" },
  Visual = { ctermbg = 81, ctermfg = 16, bg = "Grey27" },
  VertSplit = { link = "WinSeparator" },

  -- Diff
  Added = { ctermfg = 10, fg = "Green2" },
  Removed = { ctermfg = 9, fg = "Magenta2" },
  Changed = { ctermfg = 14, fg = "Cyan" },

  DiffAdd = { ctermfg = 231, ctermbg = 65, bg = "#003000" },
  DiffChange = { ctermfg = 231, ctermbg = 67, bg = "#002850" },
  DiffDelete = { ctermbg = 231, ctermfg = 133, fg = "#9e009e" },
  DiffText = { ctermfg = 16, ctermbg = 251, bg = "#003b76" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { fg = "Blue" },
  RainbowDelimiterCyan = { fg = "Cyan" },
  RainbowDelimiterGreen = { fg = "Green" },
  RainbowDelimiterOrange = { fg = "Orange" },
  RainbowDelimiterPink = { fg = "Pink" },
  RainbowDelimiterRed = { fg = "Red" },
  RainbowDelimiterViolet = { fg = "Violet" },
  RainbowDelimiterYellow = { fg = "Yellow" },
}

return M
