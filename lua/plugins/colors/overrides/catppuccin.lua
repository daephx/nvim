-- Define colors for builtin colorscheme: catppuccin

---@type config.Highlights
local colors = {
  CursorLineFold = { link = "FoldColumn" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { link = "CursorColumn" },
  MatchParen = { ctermbg = 16, bg = "#353554" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Pmenu = { link = "NormalFloat" },
  StatusLine = { bg = "none" },
  TabLine = { bg = "none" },
  WinSeparator = { ctermfg = 16, fg = "#353554" },

  -- Diagnostics
  DiagnosticError = { link = "Error" },
  DiagnosticWarn = { link = "WarningMsg" },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },

  -- Diff
  DiffAdd = { ctermfg = 22, ctermbg = 4, fg = "none", bg = "#364143" },
  DiffChange = { ctermfg = 75, ctermbg = 235, fg = "none", bg = "#25293c" },
  DiffDelete = { ctermfg = 196, ctermbg = 52, fg = "#443244", bg = "#1b141b" },
  DiffText = { ctermfg = 16, ctermbg = 23, fg = "none", bg = "#3e4b6b" },

  -- Treesitter
  ["@string.special.url"] = { ctermfg = 111, fg = "#89B4FA", underline = true },
}

-- Force transparent background in dark mode.
if vim.o.background == "light" then
  colors.Normal = nil
  colors.StatusLine = nil
  colors.Visual = nil
  colors.WinSeparator = nil

  colors.DiffAdd = nil
  colors.DiffChange = nil
  colors.DiffDelete = nil
  colors.DiffText = nil
end

return colors
