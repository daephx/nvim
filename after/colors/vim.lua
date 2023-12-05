local M = {}

M.colors = {
  Normal = { bg = "none", fg = "Grey93" },
  ColorColumn = { bg = "Gray10" },
  CursorLineNr = { fg = "Gold", underline = false },
  CursorLine = { bg = "Gray15" },
  LineNr = { fg = "Gray30" },
  NonText = { fg = "Gray15" },
  SignColumn = { bg = "none" },
  VertSplit = { fg = "Gray27" },
  FloatBorder = { fg = "Gray" },
  Visual = { bg = "Gray20" },

  DiffAdd = { link = "Type" },
  DiffChange = { link = "Statement" },
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
  -- WhichKeyFloat = { bg = "none" },
}

return M
