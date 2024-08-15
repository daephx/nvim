-- Define colors for builtin colorscheme: lunaperche

local M = {}

M.colors = {
  CursorLineNr = { ctermfg = 75, fg = "#5fafff", bold = true },
  Error = { ctermfg = 16, ctermbg = 203, fg = "Black", bg = "IndianRed1" },
  ErrorMsg = { link = "Error" },
  Identifier = { ctermfg = 251, fg = "Grey79" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  Statement = { fg = "IndianRed1" },
  StatusLine = { ctermfg = 16, fg = "Grey67" },
  StatusLineNC = { ctermbg = 16, ctermfg = 243, bg = "Grey22", fg = "White" },
  Title = { link = "Define" },
  Underlined = { ctermfg = 73, fg = "#5fd7d7", underline = true },
  WinSeparator = { ctermfg = 243, fg = "Grey46" },
  Visual = { ctermbg = 24, bg = "#005f87" },
  VertSplit = { link = "WinSeparator" },

  -- Git
  Added = { ctermfg = 77, fg = "#5fd75f" },
  Changed = { ctermfg = 75, fg = "#5fafff" },
  Removed = { ctermfg = 203, fg = "#ff5f5f" },

  -- Diff
  DiffAdd = { ctermfg = 96, bg = "#202d20" },
  DiffChange = { ctermfg = 59, bg = "#1e2b38" },
  DiffDelete = { ctermbg = 52, ctermfg = 167, bg = "#301414", fg = "#ff5f5f" },
  DiffText = { ctermfg = 66, bg = "#3a5252" },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 113, bg = "#004e2a", fg = "#5fd75f" },
  NeogitDiffAddHighlight = { fg = "#ffd787", bg = "Grey17" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 110, bg = "#202a3e", fg = "#87afd7" },
  NeogitDiffContext = { bg = "#26292e" },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 167, bg = "#301414", fg = "#ff5f5f" },
  NeogitDiffDeleteHighlight = { fg = "Black", bg = "Black" },
  NeogitDiffText = { ctermbg = 213, bg = "#3a4772" },
  NeogitHunkHeader = { bg = "Gray31", fg = "#ff87ff" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 75, fg = "#5fafff", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 80, fg = "#5fd7d7", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 77, fg = "#5fd75f", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 215, fg = "#ffa75f", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 203, fg = "#ff5f5f", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 213, fg = "#ff87ff", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 222, fg = "#ffd787", nocombine = true },
}

return M
