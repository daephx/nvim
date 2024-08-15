-- Define colors for builtin colorscheme: murphy

local M = {}

M.colors = {
  CursorLine = { bg = "Gray15" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  CursorLinrNr = { ctermbg = "none", bg = "none", fg = "Yellow", bold = true },
  EndOfBuffer = { ctermfg = 21, fg = "Blue1" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { bg = "Gray12" },
  IncSearch = { ctermfg = 40, bg = "Green" },
  NormalFloat = { link = "Normal" },
  Normal = { ctermbg = "none", bg = "none" },
  PmenuSel = { ctermbg = 21, bg = "Blue1" },
  Statement = { fg = "Violet" },
  WinSeparator = { fg = "Gray32" },
  Constant = { fg = "IndianRed" },
  Visual = { ctermbg = 22, bg = "#005f00" },
  VertSplit = { link = "WinSeparator" },
  MsgSeparator = { link = "WinSeparator" },
  Error = { ctermbg = 196, bg = "#ff0000" },
  ErrorMsg = { link = "Error" },

  -- Git
  Added = { ctermfg = 40, fg = "Green3" },
  Changed = { ctermfg = 75, fg = "SteelBlue2" },
  Removed = { ctermfg = 196, fg = "Red" },

  -- Diff
  DiffAdd = { ctermbg = 4, ctermfg = 40, bg = "#0a300a" },
  DiffChange = { ctermbg = 5, ctermfg = 75, bg = "#002a4c" },
  DiffDelete = { ctermbg = 12, ctermfg = 196, fg = "#bb4c4c" },
  DiffText = { ctermbg = 23, bg = "#005498" },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 40, bg = "#0a300a", fg = "Green3" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 75, bg = "#002a4c" },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 196, fg = "#bb4c4c", bg = "#301414" },
  NeogitDiffText = { ctermbg = 238, bg = "Grey27" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 5, fg = "Blue", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 6, fg = "Cyan", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 2, fg = "Green", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "Orange", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 218, fg = "Pink", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 1, fg = "Red", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 5, fg = "Magenta", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 3, fg = "Yellow", nocombine = true },
}

return M
