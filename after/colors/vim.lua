-- Define colors for builtin colorscheme: vim

---@type config.Highlights
return {
  ColorColumn = { ctermbg = 234, bg = "Grey10" },
  Cursor = { ctermfg = 220, bg = "Gold" },
  CursorLine = { ctermbg = 235, bg = "Grey15" },
  CursorLineNr = { ctermfg = 220, fg = "Gold", underline = false },
  FloatBorder = { link = "WinSeparator" },
  FoldColumn = { link = "Normal" },
  Folded = { ctermbg = 237, bg = "Grey23" },
  Identifier = { ctermfg = 14, fg = "Cyan" },
  LineNr = { ctermfg = 239, fg = "Grey30" },
  MatchParen = { ctermbg = 243, bg = "Grey46" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 235, fg = "Grey15" },
  Normal = { ctermfg = 255, fg = "Grey93" },
  Pmenu = { ctermbg = "none", bg = "none" },
  PmenuSel = { ctermbg = 238, ctermfg = 15, bg = "Grey27" },
  SignColumn = { ctermbg = "none", bg = "none" },
  Title = { link = "Special" },
  WinSeparator = { ctermfg = 238, fg = "Grey27" },
  Visual = { ctermfg = 15, ctermbg = 240, bg = "Grey35" },
  VertSplit = { link = "WinSeparator" },

  -- StatusLine
  StatusLine = { ctermbg = "none", bg = "none" },
  StatusLineNC = { ctermbg = "none", bg = "none" },
  TabLineFill = { ctermbg = "none", bg = "none" },

  -- Search
  CurSearch = { ctermbg = 3, ctermfg = 16, bg = "Yellow", fg = "Black" },
  IncSearch = { reverse = true },
  Search = { ctermbg = 172, ctermfg = 16, bg = "Orange", fg = "Black" },

  -- Git
  Added = { ctermfg = 40, fg = "Green3" },
  Changed = { ctermfg = 75, fg = "SteelBlue2" },
  Removed = { ctermfg = 196, fg = "Red" },

  -- Diff
  DiffAdd = { ctermbg = 4, ctermfg = 40, bg = "#0a300a" },
  DiffChange = { ctermbg = 5, ctermfg = 75, bg = "#002a4c" },
  DiffDelete = { ctermbg = 12, ctermfg = 196, fg = "#bb4c4c" },
  DiffText = { ctermbg = 23, bg = "#005498" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 5, fg = "Blue", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 6, fg = "Cyan", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 2, fg = "Green", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "Orange", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 218, fg = "Pink", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 1, fg = "Red", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 5, fg = "Magenta", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 3, fg = "Yellow", nocombine = true },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 40, bg = "#0a300a", fg = "Green3" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 75, bg = "#002a4c" },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 196, fg = "#bb4c4c", bg = "#301414" },
  NeogitDiffText = { ctermbg = 238, bg = "Grey27" },

  -- Telescope
  TelescopeNormal = { link = "Normal" },
  TelescopePreviewBorder = { link = "FloatBorder" },
  TelescopePromptBorder = { link = "FloatBorder" },
  TelescopeResultsBorder = { link = "FloatBorder" },
  TelescopeSelection = { ctermbg = 236, bg = "Grey23" },
  TelescopeSelectionCaret = { ctermfg = 214, fg = "Orange" },

  -- Whichkey
  WhichKey = { link = "Define" },
}
