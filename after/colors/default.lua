local M = {}

M.colors = {
  Normal = { ctermfg = 253, bg = "none", fg = "NvimLightGrey2" },
  CursorLineNr = { ctermfg = 222, fg = "NvimLightYellow" },
  FloatBorder = { link = "WinSeparator" },
  NonText = { ctermfg = 239, fg = "Gray15" },
  WinSeparator = { ctermfg = 236, fg = "NvimDarkGrey3" },

  GitSignsAdd = { ctermfg = 157, fg = "NvimLightGreen", bold = true },
  GitSignsChange = { ctermfg = 222, fg = "NvimLightYellow", bold = true },
  GitSignsDelete = { ctermfg = 217, fg = "NvimLightRed", bold = true },

  -- Dashboard
  DashboardHeader = { link = "Comment" },
  DashboardDesc = { link = "String" },
  DashboardFooter = { link = "Comment" },
  DashboardIcon = { link = "String" },
  DashboardShortCut = { link = "Keyword" },
  DashboardKey = {},

  -- Telescope
  TelescopeBorder = { ctermfg = 253, fg = "NvimLightGrey2" },
  TelescopeSelection = { ctermbg = 236, bg = "NvimDarkGrey3" },
  TelescopePreviewBorder = { link = "WinSeparator" },
  TelescopePromptBorder = { link = "WinSeparator" },
  TelescopeResultsBorder = { link = "WinSeparator" },
}

return M
