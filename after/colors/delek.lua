local M = {}

M.colors = {
  FloatBorder = { link = "WinSeparator" },
  NonText = { fg = "Gray15" },
  SignColumn = { bg = "none" },
  WinSeparator = { fg = "Gray" },
  VertSplit = { link = "WinSeparator" },

  -- Git
  DiffAdd = { fg = "Green", bg = "none" },
  DiffChange = { fg = "Yellow", bg = "none" },
  DiffDelete = { fg = "Red", bg = "none" },

  -- Telescope
  TelescopeNormal = { bg = "none" },
}

return M
