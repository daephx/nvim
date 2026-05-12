-- Define colors for builtin colorscheme: torte

---@type config.Highlights
return {
  CursorLine = { ctermbg = 235, bg = "Grey15" },
  CursorLineFold = { ctermbg = "none", bg = "none" },
  CursorLineNr = { ctermfg = 3, fg = "Yellow" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  FloatBorder = { link = "VertSplit" },
  Folded = { ctermbg = 234, bg = "Grey11" },
  NonText = { ctermfg = 239, fg = "Grey30" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  PmenuSel = { ctermfg = 16, ctermbg = 226, fg = "Black", bg = "Yellow1" },
  StatusLineNC = { ctermbg = 16, ctermfg = 243, bg = "Grey15", fg = "White" },
  TablineFill = { ctermbg = "none", bg = "none" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermbg = 238, bg = "Grey27" },
  WinSeparator = { ctermfg = 239, fg = "Grey30" },

  -- Search
  CurSearch = { link = "IncSearch" },
  IncSearch = { ctermfg = 16, ctermbg = 40, fg = "Black", bg = "Green" },
  Search = { ctermbg = 3, ctermfg = 16, bg = "Yellow", fg = "Black" },

  -- Git
  Added = { ctermfg = 40, fg = "Green3" },
  Changed = { ctermfg = 75, fg = "Blue" },
  Removed = { ctermfg = 196, fg = "Red" },

  -- Diff
  DiffAdd = { ctermfg = 40, ctermbg = 232, fg = "none", bg = "#0a300a" },
  DiffChange = { ctermfg = 75, ctermbg = 232, fg = "none", bg = "#002a4c" },
  DiffDelete = { ctermfg = 196, ctermbg = 232, fg = "#bb4c4c", bg = "#301414" },
  DiffText = { ctermfg = "none", ctermbg = 238, fg = "none", bg = "Grey27" },

  -- Neogit
  NeogitDiffAdd = { ctermfg = 40, ctermbg = 232, fg = "Green3", bg = "#0a300a" },
  NeogitDiffChange = { ctermfg = 75, ctermbg = 232, fg = "none", bg = "#002a4c" },
  NeogitDiffDelete = { ctermfg = 196, ctermbg = 232, fg = "#bb4c4c", bg = "#301414" },
  NeogitDiffText = { ctermfg = "none", ctermbg = 238, fg = "none", bg = "Grey27" },
}
