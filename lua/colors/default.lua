local M = {}

M.group_overrides = {
  ColorColumn = { bg = "SteelBlue" },
  CursorLineNr = { fg = "Gold", underline = false },
  LineNr = { fg = "Gray" },
  NonText = { fg = "#222222" },
  SignColumn = { bg = "none" },
  VertSplit = { fg = "#444444" },
  FloatBorder = { fg = "Gray" },

  DiffAdd = { link = "Type" },
  DiffChange = { link = "Statement" },
  DiffDelete = { fg = "Red", bg = "none" },

  TelescopeNormal = { bg = "none" },
  TelescopePromptBorder = { fg = "Gray" },
  TelescopePreviewBorder = { fg = "Gray" },
  TelescopeResultsBorder = { fg = "Gray" },

  IndentBlanklineChar = { link = "LineNr" },
}

-- If termguicolors is disabled, gitsigns will not have any color.
-- hi DiffAdd ctermfg=2
-- hi DiffChange ctermfg=3
-- hi DiffDelete ctermfg=3

-- hi VertSplit ctermfg=8
-- hi LineNr ctermfg=8
-- hi FloatBorder ctermfg=8
-- hi NonText ctermfg=8

return M
