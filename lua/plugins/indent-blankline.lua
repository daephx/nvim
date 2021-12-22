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
  enabled = true,
  char_highlight = 'LineNr',
  show_end_of_line = false,
  show_first_indent_level = false,
  space_char_blankline = ' ',
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter = true,

  -- char = "| ",
  -- char_highlight_list = {
  --   'IndentBlanklineIndent1',
  --   'IndentBlanklineIndent2',
  --   'IndentBlanklineIndent3',
  --   'IndentBlanklineIndent4',
  --   'IndentBlanklineIndent5',
  --   'IndentBlanklineIndent6',
  -- },

  buftype_exclude = {
    'help',
    'nofile',
    'terminal'
  },
  filetype_exclude = {
    "",
    "LuaTree",
    "NvimTree",
    "UltestOutput",
    "UltestSummary",
    "dapui_breakpoints",
    "dapui_hover",
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "dashboard",
    "dbui",
    "fugitive",
    "fugitiveblame",
    "help",
    "packer",
    "term",
  },
}
