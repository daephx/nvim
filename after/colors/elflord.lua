-- Define colors for builtin colorscheme: elflord

---@type config.Highlights
return {
  CursorLineFold = { ctermbg = "none", bg = "none" },
  CursorLineNr = { ctermfg = 3, fg = "Yellow", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  EndOfBuffer = { link = "NonText" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 235, bg = "Grey15" },
  IncSearch = { ctermbg = 214, bg = "LightBlue" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 44, fg = "#00cdcd" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalBorder = { link = "WinSeparator" },
  NormalFloat = { link = "Normal" },
  Pmenu = { link = "NormalFloat" },
  TablineFill = { ctermbg = "none", bg = "none" },
  WinSeparator = { ctermfg = 44, fg = "#00cdcd" },
  VertSplit = { link = "WinSeparator" },

  -- Git
  Added = { ctermfg = 46, fg = "#00ff00" },
  Changed = { ctermfg = 63, fg = "#3a66ff" },
  Removed = { ctermfg = 201, fg = "#f564f5" },

  -- Diff
  DiffAdd = { ctermbg = 4, ctermfg = 40, bg = "#0a300a" },
  DiffChange = { ctermbg = 5, ctermfg = 75, bg = "#002a4c" },
  DiffDelete = { ctermbg = 12, ctermfg = 196, fg = "#c24fc2" },
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
}
