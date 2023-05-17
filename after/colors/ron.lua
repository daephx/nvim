local M = {}

M.colors = {
  Normal = { bg = "none" },
  Comment = { fg = "Gray45" },
  CursorLine = { bg = "none" },
  CursorLineNr = { bg = "none", fg = "Yellow" },
  EndOfBuffer = { fg = "Grey17" },
  LineNr = { fg = "Gray35" },
  MsgSeparator = { link = "VertSplit" },
  NonText = { fg = "Gray15" },
  FloatBorder = { link = "VertSplit" },
  SignColumn = { bg = "none" },
  StatusLine = { bg = "Blue", fg = "Gray80" },
  StatusLineNC = { bg = "NavyBlue" },
  VertSplit = { fg = "Gray35" },

  DiffAdd = { fg = "Green", bg = "none" },
  DiffChange = { fg = "Yellow", bg = "none" },
  DiffDelete = { fg = "Red", bg = "none" },

  -- Telescope
  TelescopeNormal = { link = "Normal" },
  TelescopePreviewBorder = { fg = "Gray" },
  TelescopePromptBorder = { fg = "Gray" },
  TelescopeResultsBorder = { fg = "Gray" },
  TelescopeSelection = { bg = "Gray23" },

  -- Indent Blankline
  IndentBlanklineChar = { link = "LineNr" },

  -- Whichkey
  WhichKey = { link = "Define" },
  WhichKeyFloat = { bg = "Gray5" },
}

return M
