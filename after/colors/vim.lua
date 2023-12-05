-- Define colors for builtin colorscheme: vim

local M = {}

M.colors = {
  Normal = { bg = "none", fg = "Grey93" },
  FloatBorder = { link = "WinSeparator" },

  ColorColumn = { bg = "Gray10" },
  CursorLine = { bg = "Gray15" },
  CursorLineNr = { fg = "Gold", underline = false },
  LineNr = { fg = "Gray30" },
  NonText = { fg = "Gray15" },
  MsgSeparator = { link = "VertSplit" },
  SignColumn = { bg = "none" },
  VertSplit = { fg = "Gray27" },
  Visual = { bg = "Gray25" },
  WinSeparator = { ctermfg = 236, fg = "Gray24" },

  CurSearch = { bg = "Yellow" },
  Search = { bg = "Yellow4" },

  -- Pmenu
  Pmenu = { bg = "none", reverse = false },
  PmenuSel = {
    bg = "Grey25",
    fg = "Grey54",
    blend = 0,
    underline = true,
    reverse = true,
  },

  -- Diff
  DiffAdd = { link = "Type" },
  DiffChange = { link = "Statement" },
  DiffDelete = { fg = "Red", bg = "none" },

  -- Telescope
  TelescopeNormal = { link = "Normal" },
  TelescopePreviewBorder = { link = "WinSeparator" },
  TelescopePromptBorder = { link = "WinSeparator" },
  TelescopeResultsBorder = { link = "WinSeparator" },
  TelescopeSelection = { bg = "Gray23" },

  -- Indent Blankline
  IndentBlanklineChar = { link = "LineNr" },

  -- Whichkey
  WhichKey = { link = "Define" },
  WhichKeyFloat = { bg = "none" },
}

return M
