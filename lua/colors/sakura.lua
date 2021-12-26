local cmd = vim.cmd
local g = vim.g

--- Globals ---

--- Locals ---

local M = {}

function M.highlights()

  vim.cmd([[

  " Disable italic comments
  highlight Comment gui=none

  " Cusror Number
  " highlight CursorLineNr guibg=none

  " Special strings
  highlight String guifg=#CBAA73
  highlight SpecialChar guifg=#56B1BB

  ]])

end

return M
