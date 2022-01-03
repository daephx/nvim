local g = vim.g

--- Globals ---

g.tokyonight_style = 'night'
g.tokyonight_dark_float = true
g.tokyonight_terminal_colors = false
g.tokyonight_transparent = true
g.tokyonight_transparent_sidebar = true
g.tokyonight_italic_comments = false
g.tokyonight_italic_keywords = false

g.tokyonight_sidebars = {
  'qf',
  'Touble',
  'vista_kind',
  'terminal',
  'packer',
}

g.tokyonight_colors = {
  hint = "orange",
}


--- Highlights ---

local M = {}

M.highlights = {
  String = {fg = '#cbaa73'},
  FoldColumn = {bg = 'none'},

  -- Disable background for Treesitter warnings
  TSNote = {clear = true},
  TSWarning = {clear = true},
  TSDanger = {clear = true},
}

return M
