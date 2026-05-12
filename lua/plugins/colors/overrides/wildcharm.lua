-- Define colors for builtin colorscheme: wildcharm

---@type config.Highlights
local colors = {
  CursorLineNr = { ctermfg = 213, fg = "Orchid1", bold = true },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  StatusLine = { ctermbg = 81, ctermfg = 15, fg = "White" },
  StatusLineNC = { ctermbg = 237, ctermfg = 243, bg = "Grey23", fg = "White" },
  Title = { link = "Define" },
  Underlined = { ctermfg = 39, fg = "#00afff", underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermbg = 25, ctermfg = 16, bg = "#144454" },
  WinSeparator = { ctermfg = 240, fg = "#585858" },

  -- Diagnostics
  DiagnosticError = { link = "Error" },
  DiagnosticInfo = { ctermfg = 32, fg = "#00afff" },
  DiagnosticOk = { ctermfg = 35, fg = "#00d75f" },
  Error = { ctermfg = 161, fg = "#d7005f" },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },

  -- Git
  Added = { ctermfg = 35, fg = "#00d75f" },
  Changed = { ctermfg = 32, fg = "#00afff" },
  Removed = { ctermfg = 161, fg = "#ff5f87" },

  -- Diff
  DiffAdd = { ctermfg = "none", ctermbg = 65, fg = "none", bg = "#122e20" },
  DiffChange = { ctermfg = "none", ctermbg = 59, fg = "none", bg = "#1e383e" },
  DiffDelete = { ctermfg = 217, ctermbg = 234, fg = "#ff5f87", bg = "#31121a" },
  DiffText = { ctermfg = "none", ctermbg = 66, fg = "none", bg = "#305252" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 39, fg = "#00afff", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 44, fg = "#00d7d7", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 41, fg = "#00d75f", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "#ffaf00", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 213, fg = "#ff87ff", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 204, fg = "#ff5f87", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 99, fg = "#875fff", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 220, fg = "#ffe800", nocombine = true },
}

-- Force transparent background in dark mode.
if vim.o.background == "light" then
  colors.Normal = nil
  colors.Visual = { ctermbg = 25, ctermfg = 16, bg = "#abdbeb" }
  colors.WinSeparator = { ctermfg = 240, fg = "#a7a7a7" }

  colors.DiffAdd = { ctermfg = "none", ctermbg = 65, fg = "none", bg = "#d1eddf" }
  colors.DiffChange = { ctermfg = "none", ctermbg = 59, fg = "none", bg = "#c1dbe1" }
  colors.DiffDelete = { ctermfg = 217, ctermbg = 234, fg = "#ff5f87", bg = "#edced5" }
  colors.DiffText = { ctermfg = "none", ctermbg = 66, fg = "none", bg = "#adcece" }
end

return colors
