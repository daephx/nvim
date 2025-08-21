-- Define colors for builtin colorscheme: unokai

---@type config.Highlights
local colors = {
  ColorColumn = { ctermbg = 235, bg = "#282923" },
  CursorLine = { ctermbg = 237, bg = "#26251e" },
  CursorLineNr = { ctermfg = 213, fg = "#e6db74", bold = true },
  EndOfBuffer = { link = "LineNr" },
  Folded = { ctermfg = 250, ctermbg = 235, fg = "#e6db74", bg = "#3c3930" },
  LineNr = { ctermfg = 245, fg = "#585546" },
  LineNrAbove = { link = "LineNr" },
  LineNrBelow = { link = "LineNr" },
  MsgSeparator = { link = "WinSeparator" },
  NonText = { ctermfg = 245, fg = "#666251" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { link = "Normal" },
  PmenuSel = { link = "Visual" },
  StatusLine = { link = "Normal" },
  TabLineFill = { link = "Normal" },
  Title = { link = "Define" },
  Underlined = { ctermfg = 81, fg = "#51aebe", underline = true },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermfg = 116, ctermbg = 235, fg = "none", bg = "#273b38" },
  WinSeparator = { ctermfg = 244, fg = "#74705d" },

  -- Diagnostics
  DiagnosticError = { link = "Error" },
  DiagnosticHint = { ctermfg = 81, fg = "#51aebe" },
  DiagnosticOk = { ctermfg = 106, fg = "#81af24" },
  Error = { ctermfg = 161, fg = "#c61e5c" },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },

  -- Git
  Added = { ctermfg = 106, fg = "#81af24" },
  Changed = { ctermfg = 81, fg = "#51aebe" },
  Removed = { ctermfg = 161, fg = "#c61e5c" },

  -- Diff
  DiffAdd = { ctermfg = "none", ctermbg = 65, fg = "none", bg = "#222f09" },
  DiffChange = { ctermfg = "none", ctermbg = 59, fg = "none", bg = "#1a383d" },
  DiffDelete = { ctermfg = 161, ctermbg = 234, fg = "#c61e5c", bg = "#2c0614" },
  DiffText = { ctermfg = "none", ctermbg = 66, fg = "none", bg = "#253735" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 81, fg = "#66d9ef", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 158, fg = "#a1efe4", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 148, fg = "#a6e22e", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 208, fg = "#fd971f", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 205, fg = "#ec719e", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 161, fg = "#c61e5c", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 141, fg = "#ae81ff", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 186, fg = "#e6db74", nocombine = true },

  -- Neogit
  NeogitDiffAdd = { ctermbg = 236, ctermfg = 40, bg = "#222f09", fg = "#81af24" },
  NeogitDiffChange = { ctermbg = 236, ctermfg = 75, bg = "#1a383d" },
  NeogitDiffDelete = { ctermbg = 52, ctermfg = 196, fg = "#c61e5c", bg = "#2c0614" },
  NeogitDiffText = { ctermfg = "none", ctermbg = 66, fg = "none", bg = "#253735" },

  NeogitActiveItem = { ctermbg = 235, ctermfg = 208, bg = "#282923", fg = "#fd971f" },
  NeogitCommitViewDescription = { link = "Normal" },
  NeogitObjectId = { ctermfg = 139, fg = "#ec719e" },
}

return colors
