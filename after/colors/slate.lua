-- Define colors for builtin colorscheme: slate

---@type config.Highlights
return {
  ColorColumn = { ctermbg = 234, bg = "#232315" },
  CursorLine = { ctermbg = 235, bg = "Grey15" },
  CursorLineNr = { ctermfg = 186, fg = "#d7d787" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 234, bg = "Grey11" },
  NonText = { ctermfg = 238, fg = "Grey27" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { ctermbg = "none", bg = "none" },
  PmenuThumb = { ctermbg = 186, bg = "#d7d787" },
  SignColumn = { ctermbg = "none", bg = "none" },
  Statement = { ctermfg = 177, fg = "Violet" },
  StatusLineNC = { ctermbg = 235, bg = "Grey15" },
  Structure = { ctermfg = 64, fg = "#5f8700" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermfg = 186, ctermbg = 64, fg = "#d7d787", bg = "#5f8700" },
  WinSeparator = { ctermfg = 186, fg = "#d7d787" },

  -- Search
  CurSearch = { link = "IncSearch" },
  IncSearch = { ctermfg = 16, ctermbg = 46, fg = "Black", bg = "#5f8700" },
  Search = { ctermfg = 16, ctermbg = 173, fg = "Black", bg = "#d7875f" },

  -- Git
  Added = { ctermfg = 40, fg = "#6fa000" },
  Changed = { ctermfg = 75, fg = "#5980cc" },
  Removed = { ctermfg = 196, fg = "#b448ac" },

  -- Diff
  DiffAdd = { ctermfg = 231, ctermbg = 65, fg = "none", bg = "#1f381f" },
  DiffChange = { ctermfg = 231, ctermbg = 67, fg = "none", bg = "#243443" },
  DiffDelete = { ctermfg = 231, ctermbg = 133, fg = "#9c3f95", bg = "#3c203c" },
  DiffText = { ctermfg = 16, ctermbg = 251, fg = "none", bg = "#525252" },

  -- Neogit
  NeogitDiffAdd = { ctermfg = 231, ctermbg = 65, fg = "#5f8700", bg = "#1f381f" },
  NeogitDiffChange = { ctermfg = 231, ctermbg = 67, fg = "#5f87d7", bg = "#243443" },
  NeogitDiffDelete = { ctermfg = 231, ctermbg = 133, fg = "#9c3f95", bg = "#3c203c" },

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
