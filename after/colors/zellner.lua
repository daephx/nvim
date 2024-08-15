-- Define colors for builtin colorscheme: zellner

local M = {}

M.colors = {
  NonText = { ctermfg = 235, fg = "Grey15" },
  NormalFloat = { bg = "Grey82" },
  SignColumn = { ctermbg = 15, bg = "none" },
  StatusLine = { ctermbg = "none", ctermfg = 234, bg = "White", fg = "Grey7" },
  StatusLineNC = { ctermfg = 234, ctermbg = 243, bg = "Grey36", fg = "Grey11" },
  TablineFill = { ctermbg = 16, bg = "none" },
  WinSeparator = { ctermfg = 7, fg = "Grey" },

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
