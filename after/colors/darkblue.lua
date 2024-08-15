-- Define colors for builtin colorscheme: darkblue

local M = {}

M.colors = {
  CurSearch = { link = "IncSearch" },
  CursorLine = { ctermbg = 236, bg = "Grey19" },
  CursorLineFold = { ctermbg = "none", bg = "none" },
  CursorLineNr = { ctermfg = 3, fg = "Yellow" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  Error = { ctermfg = 217, fg = "#ffa0a0" },
  ErrorMsg = { link = "Error" },
  Folded = { ctermbg = 234, bg = "Grey11" },
  IncSearch = { ctermfg = 40, bg = "Green" },
  LineNr = { ctermfg = 239, fg = "Grey30" },
  MatchParen = { ctermbg = 241, bg = "Grey39" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = 105, bg = "#00004d" },
  PmenuSel = { ctermbg = 59, bg = "Grey32" },
  Statement = { ctermfg = 177, fg = "Violet" },
  StatusLine = { ctermfg = 239, ctermbg = 18, fg = "Grey30", bg = "#000040" },
  StatusLineNC = { ctermbg = 18, ctermfg = 239, fg = "Grey30", bg = "#000080" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermbg = 105, bg = "#000080" },
  WinSeparator = { ctermfg = 239, fg = "Grey30" },

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
}

return M
