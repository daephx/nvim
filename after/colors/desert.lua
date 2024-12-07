-- Define colors for builtin colorscheme: desert

---@type config.Highlights
return {
  FloatBorder = { link = "WinSeparator" },
  NonText = { fg = "Gray15" },
  SignColumn = { bg = "none" },
  Special = { ctermfg = 147, fg = "LightSteelBlue2" },
  StatusLine = { ctermfg = 238, fg = "Grey27" },
  StatusLineNC = { ctermfg = 242, ctermbg = 144, fg = "Gray42", bg = "#555238" },
  VertSplit = { link = "WinSeparator" },
  Visual = { ctermbg = 237, bg = "#48442a" },
  WinSeparator = { ctermfg = 144, fg = "#c2bfa5" },

  -- Diff
  Added = { ctermfg = 115, fg = "DarkSeaGreen3" },
  Changed = { ctermfg = 231, fg = "LightSteelBlue3" },
  Removed = { ctermfg = 211, fg = "PaleVioletRed1" },

  DiffAdd = { bg = "#303222" },
  DiffChange = { bg = "#2e3644" },
  DiffDelete = { fg = "PaleVioletRed1" },
  DiffText = { bg = "#5e5838" },

  -- Telescope
  TelescopeTitle = { link = "Title" },
}
