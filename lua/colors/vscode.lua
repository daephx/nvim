local cmd = vim.cmd
local g = vim.g

--- Globals ---

g.vscode_style = 'dark'


--- Locals ---

local M = {}

function M.highlights()

  -- Disable italic comments]]
  cmd [[highlight Comment gui=none ctermfg=gray guifg=#626262]]

  -- cmd [[highlight LineNr guibg=none]]
  cmd [[highlight String guifg=#CBAA73]]

  -- Git status
  cmd [[
    " highlight DiffAdd guibg=green
    highlight DiffChange guibg=#464C18
    " highlight DiffDelete guibg=red
  ]]

  -- Special strings
  cmd [[highlight SpecialChar guifg=#56B1BB]]

  -- Floating Windows
  cmd [[highlight FloatBorder guifg=#5A5A5A guibg=none]]
end

return M
