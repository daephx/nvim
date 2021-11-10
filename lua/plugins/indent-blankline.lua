-- Module: plugins.indent-blankline
-- Description: Plugin configuration for indentation guides

local fn = vim.fn

-- Prevent loading if not applicable
if not fn.exists('g:loaded_indent_blankline') then
  return
end


--- Settings ---

-- Ensure terminal colors is enabled for blankline context

local indent_blankline = require('indent_blankline')

indent_blankline.setup {
  buftype_exclude = {'help', 'nofile', 'terminal'},
  filetype_exclude = {'dashboard', 'packer', 'help'},
  char_highlight = 'LineNr',
  show_end_of_line = false,
  space_char_blankline = '⋅',
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter = true,

  char_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
    'IndentBlanklineIndent3',
    'IndentBlanklineIndent4',
    'IndentBlanklineIndent5',
    'IndentBlanklineIndent6',
  },
}
