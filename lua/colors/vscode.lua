-- VSCode | Colorscheme settings

local g = vim.g

--- Globals ---

g.vscode_style = "dark"
g.vscode_transparent = 1

--- Highlights ---

local M = {}

M.highlights = {

  Comment = { fg = "#626262" },
  String = { fg = "#CBAA73" },
  SpecialChar = { fg = "#56B1BB" },
  LineNr = { bg = "none" },
  Visual = { bg = "#0C243C", fg = "none" },
  EndOfBuffer = { fg = "#222222" },

  -- Git status
  DiffAdd = { bg = "#212D19", fg = "none" },
  DiffChange = { bg = "#3B3814", fg = "none" },
  DiffDelete = { bg = "none", fg = "indianred" },

  -- Floating Windows
  FloatNormal = { bg = "none" },
  FloatBorder = { fg = "#5A5A5A", bg = "none" },
  LspFloatWinNormal = { link = "NormalFloat" },
  NormalFloat = { link = "Pmenu" },

  -- NvimTree
  NvimTreeNormal = { bg = "none" },

  -- Lualine | Might want to add to custom theme
  lualine_a_inactive = { bg = "#1e1e2e" },
}

return M
