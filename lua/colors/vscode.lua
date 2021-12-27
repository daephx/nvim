local g = vim.g

--- Globals ---

g.vscode_style = 'dark'

--- Locals ---

local M = {}

function M.highlights()
  vim.cmd([[

  " Disable italic comments
  highlight Comment gui=none ctermfg=gray guifg=#626262

  " Disable LineNr background
  highlight LineNr guibg=none
  highlight String guifg=#CBAA73

  " Git status
  " highlight DiffAdd guibg=green
  highlight DiffChange guibg=#464C18
  " highlight DiffDelete guibg=red

  " Special strings
  highlight SpecialChar guifg=#56B1BB

  " Floating Windows
  highlight FloatBorder guifg=#5A5A5A guibg=none

  ]])
end

return M
