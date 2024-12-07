-- Define colors for builtin colorscheme: quiet

---@type config.HighlightsTbl
local colors = {
  ErrorMsg = { link = "Error" },
  IncSearch = { ctermbg = 52, bg = "DarkRed" },
  MsgSeparator = { link = "WinSeparator" },
  NormalFloat = { link = "Normal" },
  WinSeparator = { ctermfg = 239, fg = "Grey32" },
  VertSplit = { link = "WinSeparator" },

  -- Git
  Added = { ctermfg = 40, fg = "Green4" },
  Changed = { ctermfg = 75, fg = "SteelBlue3" },
  Removed = { ctermfg = 196, fg = "Red3" },

  -- Diff
  DiffAdd = { ctermbg = 34, bg = "#00af00" },
  DiffChange = { ctermbg = 110, bg = "#87afd7" },
  DiffDelete = { ctermfg = 167, fg = "#d75f5f" },
  DiffText = { ctermbg = 176, bg = "#d787d7" },
}

---@type string[]
local terminal_dark = {
  "#000000",
  "#d7005f",
  "#00af5f",
  "#d78700",
  "#0087d7",
  "#d787d7",
  "#00afaf",
  "#dadada",
  "#707070",
  "#ff005f",
  "#00d75f",
  "#ffaf00",
  "#5fafff",
  "#ff87ff",
  "#00d7d7",
  "#ffffff",
}

---@type config.HighlightsTbl
local dark = {
  CursorLine = { ctermbg = 235, bg = "Grey15" },
  CursorLineNr = { ctermfg = 7, fg = "White", bold = true },
  Error = { ctermfg = 197, ctermbg = 16, fg = "#d7005f", bg = "Black", bold = true },
  Folded = { ctermbg = 233, bg = "Grey7" },
  MatchParen = { ctermbg = 237, bg = "Grey37", bold = true },
  Normal = {},
  Pmenu = { ctermbg = 239, ctermfg = 248, fg = "#a8a8a8", bg = "#4e4e4e" },
  StatusLine = { ctermfg = 248, fg = "Grey66" },
  StatusLineNC = { ctermfg = 234, ctermbg = 243, bg = "Grey32", fg = "Grey11" },
  Underlined = { ctermfg = 248, fg = "Grey67", underline = true },
  Visual = { ctermbg = 239, ctermfg = 16, bg = "#4b4b4b" },
  WarningMsg = { ctermfg = 3, fg = "#d78700" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 7, fg = "Grey79", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 7, fg = "Grey79", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 7, fg = "Grey79", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 7, fg = "Grey79", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 7, fg = "Grey79", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 7, fg = "Grey79", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 7, fg = "Grey79", nocombine = true },
}

---@type string[]
local terminal_light = {
  "#ffffff",
  "#af0000",
  "#005f00",
  "#af5f00",
  "#005faf",
  "#870087",
  "#008787",
  "#626262",
  "#d7d7d7",
  "#d70000",
  "#008700",
  "#d78700",
  "#0087d7",
  "#af00af",
  "#00afaf",
  "#000000",
}

---@type config.HighlightsTbl
local light = {
  CursorLineNr = { ctermfg = 16, fg = "Black" },
  Error = { ctermfg = 197, fg = "#af0000", bold = true },
  MatchParen = { ctermbg = 237, bg = "Grey77", bold = true },
  Underlined = { ctermfg = 59, fg = "Grey37", underline = true },
  Visual = { ctermfg = 248, ctermbg = 16, fg = "#a8a8a8", bg = "Black" },
  WarningMsg = { ctermfg = 3, fg = "#af5f00" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 8, fg = "Grey9", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 8, fg = "Grey9", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 8, fg = "Grey9", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 8, fg = "Grey9", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 8, fg = "Grey9", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 8, fg = "Grey9", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 8, fg = "Grey9", nocombine = true },
}

if vim.o.background == "light" then
  for i = 0, 15 do
    vim.g["terminal_color" .. i] = terminal_light[i]
  end
  return vim.tbl_extend("force", colors, light)
else
  for i = 0, 15 do
    vim.g["terminal_color" .. i] = terminal_dark[i]
  end
  return vim.tbl_extend("force", colors, dark)
end
