-- indent-blankline.nvim | Indent guides for Neovim
-- https://github.com/lukas-reineke/indent-blankline.nvim
local indent_blankline_ok, indent_blankline = pcall(require, 'indent_blankline')
if not indent_blankline_ok then
  return
end

-- Apply plugin settings
indent_blankline.setup({
  enabled = true,
  char_highlight = 'LineNr',
  show_end_of_line = false,
  show_first_indent_level = true,
  space_char_blankline = ' ',
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter = false,
  context_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
    'IndentBlanklineIndent3',
    'IndentBlanklineIndent4',
    'IndentBlanklineIndent5',
    'IndentBlanklineIndent6',
  },
  buftype_exclude = {
    "quickfix",
    'help',
    'nofile',
    'prompt',
    'terminal',
  },
  filetype_exclude = {
    '',
    'LuaTree',
    'NvimTree',
    'Outline',
    'TelescopePrompt',
    'Trouble',
    'Ultest*',
    'alpha',
    'coc*',
    'dapui*',
    'dashboard',
    'dbui',
    'floaterm',
    'flutterToolsOutline',
    'fugitive*',
    'git*',
    'help',
    'log',
    'lspinfo',
    'markdown',
    'neogit*',
    'org*',
    'packer',
    'snippets',
    'startify',
    'term',
    'text',
    'txt',
    'undotree',
    'vista',
  },
})
