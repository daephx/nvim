-- Define colors for builtin colorscheme: desert

local terminal = {
  "#000000",
  "#cd5c5c",
  "#9acd32",
  "#bdb76b",
  "#75a0ff",
  "#ecee00",
  "#cd853f",
  "#b5b199",
  "#565050",
  "#ff0000",
  "#89fb98",
  "#f0e68c",
  "#6dceeb",
  "#ffde9b",
  "#ffa0a0",
  "#dbd6b9",
}

for i = 0, 15 do
  vim.g["terminal_color_" .. i] = terminal[i + 1]
end

---@type config.Highlights
return {
  ColorColumn = { bg = "#3c1a1a" },
  Comment = { ctermfg = 81, fg = "#6dceeb", italic = true },
  CursorLine = { ctermbg = 237, bg = "#302e28" },
  CursorLineFold = { ctermbg = "none", bg = "none" },
  CursorLineSign = { ctermbg = "none", bg = "none" },
  FloatBorder = { link = "WinSeparator" },
  FoldColumn = { link = "LineNr" },
  LineNr = { ctermfg = 239, fg = "#535046" },
  MatchParen = { ctermfg = 16, ctermbg = 236, fg = "none", bg = "#6c673c" },
  NonText = { ctermfg = 66, ctermbg = "none", fg = "#5099b0", bg = "none" },
  Normal = { ctermfg = 187, ctermbg = "none", bg = "none", fg = "LightYellow3" },
  Pmenu = { link = "Normal" },
  SignColumn = { ctermbg = "none", bg = "none" },
  SpecialKey = { link = "Special" },
  StatusLine = { ctermfg = 238, fg = "Grey27" },
  StatusLineNC = { ctermfg = 242, ctermbg = 144, fg = "Grey42", bg = "#3c3927" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermfg = 16, ctermbg = 58, fg = "none", bg = "#5f5f00" },
  WinSeparator = { ctermfg = 144, fg = "#757363" },

  -- Diagnostics
  DiagnosticError = { link = "Error" },
  Error = { ctermfg = 167, fg = "#cd5c5c" },
  ErrorMsg = { link = "Error" },
  NvimInternalError = { link = "Error" },

  -- Git
  Added = { ctermfg = 113, fg = "#81a635" },
  Changed = { ctermfg = 111, fg = "#cd853f" },
  Removed = { ctermfg = 167, fg = "#cd5c5c" },

  -- Diff
  DiffAdd = { fg = "none", bg = "#343f20" },
  DiffChange = { fg = "none", bg = "#4d3117" },
  DiffDelete = { fg = "#cd5c5c", bg = "#4d2222" },
  DiffText = { fg = "none", bg = "#734922" },

  -- Neogit
  NeogitDiffAdd = { fg = "#81a635", bg = "#343f20" },
  NeogitDiffChange = { fg = "#cd853f", bg = "#4d3117" },
  NeogitDiffDelete = { fg = "#cd5c5c", bg = "#4d2222" },

  -- Rainbow delimiters
  RainbowDelimiterBlue = { ctermfg = 111, fg = "#75a0ff" },
  RainbowDelimiterCyan = { ctermfg = 81, fg = "#6dceeb" },
  RainbowDelimiterGreen = { ctermfg = 113, fg = "#9acd32" },
  RainbowDelimiterOrange = { ctermfg = 173, fg = "#cd853f" },
  RainbowDelimiterPink = { ctermfg = 217, fg = "#ffa0a0" },
  RainbowDelimiterRed = { ctermfg = 167, fg = "#cd5c5c" },
  RainbowDelimiterViolet = { ctermfg = 105, fg = "#7e74ff" },
  RainbowDelimiterYellow = { ctermfg = 226, fg = "#eeee00" },
}
