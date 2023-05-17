local M = {}

M.colors = {
  Normal = { bg = "none" },
  NormalFloat = { link = "Normal" },
  NormalBorder = { link = "VertSplit" },
  CursorLinrNr = { bg = "none" },
  EndOfBuffer = { fg = "red" },
  FloatBorder = { fg = "Gray" },
  VertSplit = { bg = "none" },

  DiffAdd = { bg = "none", fg = "#5f875f" },
  DiffChange = { bg = "none", fg = "#5f87af" },
  DiffDelete = { bg = "none", fg = "#af5faf" },

  -- Telescope
  TelescopeNormal = { link = "Normal" },
  TelescopePreviewBorder = { fg = "Gray" },
  TelescopePromptBorder = { fg = "Gray" },
  TelescopeResultsBorder = { fg = "Gray" },
  TelescopeSelection = { bg = "Gray23" },

  -- Whichkey
  WhichKey = { link = "Define" },
}

return M
