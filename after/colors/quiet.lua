-- Define colors for builtin colorscheme: quiet

---@type config.Highlights
return {
  ErrorMsg = { link = "Error" },
  IncSearch = { ctermbg = 52, bg = "DarkRed" },
  MsgSeparator = { link = "WinSeparator" },
  NormalFloat = { link = "Normal" },
  WinSeparator = { ctermfg = 239, fg = "Grey32" },
  VertSplit = { link = "WinSeparator" },

  -- Git
  Added = { ctermfg = 10, fg = "NvimLightGreen", bold = true },
  Removed = { ctermfg = 9, fg = "NvimLightRed", bold = true },
  Changed = { ctermfg = 14, fg = "NvimLightCyan", bold = true },
}
