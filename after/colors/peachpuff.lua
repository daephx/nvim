-- Define colors for builtin colorscheme: peachpuff

---@type config.Highlights
return {
  ColorColumn = { ctermbg = 173, bg = "#cc8c6c" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  TabLineFill = { ctermbg = "none", bg = "none" },
  WinSeparator = { ctermfg = 243, fg = "Black" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 5, fg = "DarkBlue", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 6, fg = "DarkCyan", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 2, fg = "DarkGreen", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "DarkOrange", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 218, fg = "Pink", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 1, fg = "DarkRed", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 5, fg = "DarkMagenta", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 3, fg = "DarkYellow", nocombine = true },

  -- Telescope
  TelescopeSelection = { link = "CursorLine" },
  TelescopeSelectionCaret = { ctermbg = 180, ctermfg = 16, bg = "#f5c195", fg = "Black" },
}
