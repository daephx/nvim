-- Define colors for builtin colorscheme: slate

local M = {}

M.colors = {
  CursorLine = { bg = "Gray15" },
  CursorLineNr = { fg = "#d7d787" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { bg = "Gray12" },
  NonText = { fg = "Gray25" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  SignColumn = { ctermbg = "none", bg = "none" },
  Statement = { fg = "Violet" },
  StatusLineNC = { bg = "Gray15" },
  Structure = { ctermfg = 64, fg = "#5f8700" },
  WinSeparator = { fg = "Gray32" },
  Visual = { ctermfg = 186, ctermbg = 64, fg = "#d7d787", bg = "#5f8700" },
  VertSplit = { link = "WinSeparator" },

  -- Git
  Added = { ctermfg = 40, fg = "Green3" },
  Changed = { ctermfg = 75, fg = "SteelBlue2" },
  Removed = { ctermfg = 196, fg = "Red" },

  -- Diff
  DiffAdd = { ctermfg = 231, ctermbg = 65, fg = "#ffffff", bg = "#5f875f" },
  DiffChange = { ctermfg = 231, ctermbg = 67, fg = "#ffffff", bg = "#5f87af" },
  DiffDelete = { ctermfg = 231, ctermbg = 133, fg = "#ffffff", bg = "#af5faf" },
  DiffText = { ctermfg = 16, ctermbg = 251, fg = "Black", bg = "#c6c6c6" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 68, fg = "#5f87d7", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 117, fg = "#87d7ff", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 46, fg = "#5f8700", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 173, fg = "#d7875f", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 217, fg = "#ffafaf", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 210, fg = "#ff8787", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 177, fg = "#d787ff", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 186, fg = "#d7d787", nocombine = true },
}

return M
