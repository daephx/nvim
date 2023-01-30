-- indent-blankline.nvim | Indent guides for Neovim
-- https://github.com/lukas-reineke/indent-blankline.nvim
local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_ok then
  return
end

-- Apply plugin settings
indent_blankline.setup({
  enabled = true,
  use_treesitter = true,
  char_highlight = "LineNr",
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = false,
  show_first_indent_level = true,
  show_trailing_blankline_indent = false,
  context_highlight_list = {
    "rainbowcol1",
    "rainbowcol2",
    "rainbowcol3",
    "rainbowcol4",
    "rainbowcol5",
    "rainbowcol6",
    "rainbowcol7",
  },
  buftype_exclude = {
    "quickfix",
    "help",
    "nofile",
    "prompt",
    "terminal",
  },
  filetype_exclude = {
    "",
    "LuaTree",
    "NvimTree",
    "Outline",
    "TelescopePrompt",
    "Trouble",
    "Ultest*",
    "alpha",
    "coc*",
    "dapui*",
    "dashboard",
    "dbui",
    "floaterm",
    "flutterToolsOutline",
    "fugitive*",
    "git*",
    "help",
    "lazy",
    "log",
    "lspinfo",
    "mason",
    "neogit*",
    "org*",
    "packer",
    "startify",
    "term",
    "undotree",
    "vista",
  },
})
