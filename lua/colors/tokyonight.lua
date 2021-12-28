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

--- Locals ---

local M = {}

function M.highlights()
  vim.cmd([[

  highlight String guifg=#CBAA73
  highlight Comment ctermfg=gray guifg=#626262

  " Git diffs
  " highlight DiffAdd guifg=
  highlight DiffChange guifg=#dea311 guibg=#463C18
  " highlight DiffDelete guifg=

  ]])
end

return M
