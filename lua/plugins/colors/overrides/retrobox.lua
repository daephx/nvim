-- Define colors for builtin colorscheme: retrobox

---@type config.Highlights
local colors = {
  ColorColumn = { ctermbg = 233, bg = "Grey7" },
  CursorLineFold = { link = "FoldColumn" },
  CursorLineNr = { ctermfg = 215, fg = "#fabd2f", bold = true },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  Error = { ctermfg = 203, fg = "#fb4934", bold = true },
  ErrorMsg = { link = "Error" },
  FloatBorder = { link = "WinSeparator" },
  FoldColumn = { ctermbg = "none", bg = "none" },
  Folded = { ctermbg = 234, bg = "Grey12" },
  IncSearch = { ctermbg = 208, ctermfg = 234, bg = "#fe8019", fg = "Grey11" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  Operator = { ctermfg = 208, fg = "#fe8019" },
  SignColumn = { ctermbg = "none", bg = "none" },
  StatusLine = { ctermfg = 246, fg = "#a89984" },
  Visual = { ctermbg = 238, bg = "#47403a" },
  WinSeparator = { ctermfg = 238, fg = "Grey32" },

  -- Git
  Added = { ctermfg = 142, fg = "#b8bb26" },
  Removed = { ctermfg = 203, fg = "#fb4934" },
  Changed = { ctermfg = 208, fg = "#fe8019" },

  -- Diff
  DiffAdd = { ctermfg = 142, ctermbg = 235, fg = "none", bg = "#3e400b" },
  DiffChange = { ctermfg = 208, ctermbg = 235, fg = "none", bg = "#643209" },
  DiffDelete = { ctermfg = 203, ctermbg = 235, fg = "#fb4934", bg = "#47140e" },
  DiffText = { ctermfg = 208, ctermbg = 235, fg = "none", bg = "#8c4309" },

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
  colors.ColorColumn = nil
  colors.FoldColumn = nil
  colors.Folded = nil
  colors.Normal = nil
  colors.StatusLine = nil
  colors.Visual = nil

  -- Diff
  colors.DiffAdd = { ctermfg = 142, ctermbg = 235, fg = "none", bg = "#ebeda1" }
  colors.DiffChange = { ctermfg = 208, ctermbg = 235, fg = "none", bg = "#f5c39b" }
  colors.DiffDelete = { ctermfg = 160, ctermbg = 235, fg = "#cb1904", bg = "#febab3" }
  colors.DiffText = { ctermfg = 208, ctermbg = 235, fg = "none", bg = "#f5ac72" }
end

return colors
