local M = {}

M.colors = {
  Normal = { bg = "none" },
  NormalFloat = { link = "Normal" },
  FloatBorder = { link = "VertSplit" },
  VertSplit = { bg = "none" },

  DiffAdd = { bg = "none" },
  DiffChange = { bg = "none" },
  DiffDelete = { bg = "none" },

  -- Telescope
  TelescopeNormal = { link = "Normal" },
  TelescopePreviewBorder = { fg = "Gray" },
  TelescopePromptBorder = { fg = "Gray" },
  TelescopeResultsBorder = { fg = "Gray" },
  TelescopeSelection = { bg = "Gray23" },
}

return M
