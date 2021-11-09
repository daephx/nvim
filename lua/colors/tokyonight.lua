local cmd = vim.cmd
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
  "qf",
  "Touble",
  "vista_kind",
  "terminal",
  "packer",
}

g.tokyonight_colors = {
  hint = "orange",
  error = "#ff0000",
}


--- Locals ---

local M = {}

function M.highlights()

  cmd [[highlight String guifg=#CBAA73]]
  cmd [[highlight Comment ctermfg=gray guifg=#626262]]

  -- cmd [[highlight DiffAdd guifg=]]
  cmd [[highlight DiffChange guifg=#dea311 guibg=#463C18]]
  -- cmd [[highlight DiffDelete guifg=]]

  -- Fix which-key.nvim background
  --[[ if packer_plugins["which-key.nvim"] then
    if g.tokyonight_dark_float == true then
      cmd('highlight! link WhichKeyFloat StatusLineNC')
    end
  end ]]

end

return M
