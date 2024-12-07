-- Define colors for builtin colorscheme: torte

---@type config.Highlights
return {
  CursorLine = { bg = "Grey15" },
  CursorLineFold = { ctermbg = "none", bg = "none" },
  CursorLineNr = { fg = "Yellow" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  FloatBorder = { link = "VertSplit" },
  Folded = { ctermbg = 234, bg = "Grey11" },
  NonText = { fg = "Grey25" },
  Normal = { bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  PmenuSel = { ctermfg = 16, ctermbg = 226, fg = "Black", bg = "Yellow1" },
  StatusLineNC = { ctermbg = 16, ctermfg = 243, bg = "Grey15", fg = "White" },
  TablineFill = { ctermbg = "none", bg = "none" },
  WinSeparator = { ctermfg = 239, fg = "Grey30" },
  Visual = { ctermbg = 238, bg = "Grey27" },

  -- Search
  CurSearch = { link = "IncSearch" },
  IncSearch = { ctermfg = 40, bg = "Green" },
  Search = { ctermbg = 3, ctermfg = 16, bg = "Yellow", fg = "Black" },

  -- Git
  Added = { ctermfg = 40, fg = "Green3" },
  Changed = { ctermfg = 75, fg = "SteelBlue2" },
  Removed = { ctermfg = 196, fg = "Red" },

  -- Diff
  DiffAdd = { ctermbg = 232, ctermfg = 40, bg = "#0a300a" },
  DiffChange = { ctermbg = 232, ctermfg = 75, bg = "#002a4c" },
  DiffDelete = { ctermbg = 232, ctermfg = 196, fg = "Red" },
  DiffText = { ctermbg = 238, bg = "Grey27" },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 40, bg = "#0a300a", fg = "Green3" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 75, bg = "#002a4c" },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 196, fg = "#bb4c4c", bg = "#301414" },
  NeogitDiffText = { ctermbg = 238, bg = "Grey27" },
}
