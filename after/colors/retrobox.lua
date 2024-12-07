-- Define colors for builtin colorscheme: retrobox

---@type config.Highlights
local colors = {
  ColorColumn = { ctermbg = 233, bg = "Grey7" },
  CursorLineNr = { ctermfg = 215, fg = "#fabd2f", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  Error = { ctermfg = 203, ctermbg = 234, fg = "#fb4934", bg = "#1c1c1c", bold = true },
  ErrorMsg = { link = "Error" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 234, bg = "Grey12" },
  IncSearch = { ctermbg = 208, ctermfg = 234, bg = "#fe8019", fg = "Grey11" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Operator = { ctermfg = 208, fg = "#fe8019" },
  SignColumn = { ctermbg = "none", bg = "none" },
  StatusLine = { ctermfg = 246, fg = "#a89984" },
  WinSeparator = { ctermfg = 238, fg = "Grey32" },
  Visual = { ctermbg = 238, bg = "#47403a" },

  -- Git
  Added = { ctermfg = 142, fg = "#b8bb26" },
  Removed = { ctermfg = 203, fg = "#fb4934" },
  Changed = { ctermfg = 208, fg = "#fe8019" },

  -- Diff
  DiffAdd = { ctermfg = 142, ctermbg = 235, bg = "#2c2c07" },
  DiffChange = { ctermfg = 208, ctermbg = 235, bg = "#2a3531" },
  DiffDelete = { ctermfg = 203, ctermbg = 235, bg = "#47140e", fg = "#ae3224" },
  DiffText = { ctermfg = 208, ctermbg = 235, bg = "#3a4844" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 108, fg = "#83a598", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 108, fg = "#8ec07c", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 142, fg = "#b8bb26", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 208, fg = "#fe8019", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 203, fg = "#fb4934", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 175, fg = "#d3869b", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 215, fg = "#fabd2f", nocombine = true },
}

-- Don't modify Normal if background is set to light mode.
if vim.o.background == "light" then
  colors.Normal = nil
  colors.StatusLine = nil
end

return colors
