-- Define colors for builtin colorscheme: habamax

---@type config.Highlights
return {
  CursorLineNr = { fg = "#d7af87", bold = true },
  Error = { ctermfg = 131, ctermbg = 234, fg = "#af5f5f", bg = "#1c1c1c" },
  ErrorMsg = { link = "Error" },
  FloatBorder = { link = "WinSeparator" },
  MatchParen = { ctermbg = 240, bg = "Grey35" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermbg = "none", bg = "none" },
  NormalFloat = { link = "Normal" },
  NvimInternalError = { link = "ErrorMsg" },
  Special = { ctermfg = 66, fg = "#68a4a4" },
  StatusLine = { ctermfg = 234, fg = "Grey62" },
  StatusLineNC = { ctermfg = 234, ctermbg = 243, bg = "Grey27", fg = "Grey17" },
  Title = { link = "Define" },
  Underlined = { ctermfg = 66, fg = "#68a4a4", underline = true },
  WinSeparator = { ctermfg = 243, fg = "Grey46" },
  Visual = { ctermbg = 109, ctermfg = 16, bg = "DeepSkyBlue4" },
  VertSplit = { link = "WinSeparator" },

  -- LSP
  DiagnosticWarn = { link = "WarningMsg" },
  DiagnosticError = { link = "Error" },

  -- Git
  Added = { ctermfg = 77, fg = "#5c925c" },
  Changed = { ctermfg = 215, fg = "#568ca6" },
  Removed = { ctermfg = 167, fg = "#ac5e5e" },

  -- Diff
  DiffAdd = { ctermbg = 71, bg = "#243224" },
  DiffChange = { ctermbg = 67, bg = "#243240" },
  DiffDelete = { ctermfg = 131, fg = "#af5f5f" },
  DiffText = { ctermbg = 139, bg = "#364a62" },

  -- Neogit
  NeogitCommitViewDescription = { link = "Normal" },
  NeogitDiffAdd = { bg = "#243224", fg = "#4e904e" },
  NeogitDiffDelete = { bg = "#583030", fg = "#af5f5f" },
  NeogitObjectId = { ctermfg = 139, fg = "#af87af" },

  -- Rainbow Delimiter
  RainbowDelimiterBlue = { ctermfg = 74, fg = "#5fafd7" },
  RainbowDelimiterCyan = { ctermfg = 109, fg = "#87afaf" },
  RainbowDelimiterGreen = { ctermfg = 114, fg = "#87d787" },
  RainbowDelimiterOrange = { ctermfg = 180, fg = "#d7af87" },
  RainbowDelimiterRed = { ctermfg = 168, fg = "#d75f87" },
  RainbowDelimiterViolet = { ctermfg = 176, fg = "#d787d7" },
  RainbowDelimiterYellow = { ctermfg = 186, fg = "#d7c387" },
}
