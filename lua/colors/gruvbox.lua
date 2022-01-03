-- Gruvbox | Colorscheme settings

local g = vim.g


--- Globals ---

g.gruvbox_contrast_dark = 'hard'
g.gruvbox_italicize_comments = 0
g.gruvbox_underline = 1
g.gruvbox_undercurl = 1
g.gruvbox_transparent_bg = 1
g.gruvbox_invert_selection = 0


--- Highlights ---

local M = {}

M.highlights = {

  Visual = {bg = '#665c54'},

  -- Git status
  DiffAdd = {fg = '#b8bb26', bg = 'none'},
  DiffChange = {fg = '#fabd2f', bg = 'none'},
  DiffDelete = {fg = '#fb4934', bg = 'none'},

  GitGutterAdd = {fg = '#b8bb26', bg = 'none'},
  GitGutterChange = {fg = '#fabd2f', bg = 'none'},
  GitGutterDelete = {fg = '#fb4934', bg = 'none'},

}

return M
