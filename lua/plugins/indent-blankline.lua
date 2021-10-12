-- File: indent-blanklines.lua
-- Description: Plugin configuration script

--- Initialization ---

-- Stop execution if plugin not loaded
if not vim.fn.exists('g:loaded_indent_blankline') then
  return
end


--- Highlights ---

-- Highlight all indentation lines
-- vim.cmd[[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd[[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd[[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd[[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd[[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd[[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- Highlight indentation context lines, alt link to MatchParen
-- vim.cmd[[highlight IndentBlanklineContextChar guifg=grey gui=nocombine]]
vim.cmd[[
  highlight clear IndentBlanklineContextChar
  highlight link IndentBlanklineContextChar MatchParen
]]

-- Highlight ListChars, including EOL
vim.cmd[[highlight NonText guifg=indianred gui=nocombine]]

--- Opts ---

vim.opt.termguicolors = true
vim.opt.list = false
-- vim.opt.listchars = {}
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
vim.opt.listchars = {
  space = "⋅",
  eol = "↴",
}

--- Plugin ----

require("indent_blankline").setup {
  buftype_exclude = {"terminal"},
  filetype_exclude = {"dashboard", "neoterm"},
  show_end_of_line = false,
  space_char_blankline = "⋅",
  show_trailing_blankline_indent = false,
  show_current_context = true,
  -- use_treesitter = true,
  -- char_highlight_list = {
  --   "IndentBlanklineIndent1",
  --   "IndentBlanklineIndent2",
  --   "IndentBlanklineIndent3",
  --   "IndentBlanklineIndent4",
  --   "IndentBlanklineIndent5",
  --   "IndentBlanklineIndent6",
  -- },
}
