local cmd = vim.cmd
local g = vim.g

--- Globals ---

--- Locals ---

local M = {}

function M.highlights()

  -- Disable italic comments
  cmd [[highlight Comment gui=none]]

  -- Cusror Number
  -- cmd [[highlight CursorLineNr guibg=none]]

  -- Special strings
  cmd [[highlight String guifg=#CBAA73]]
  cmd [[highlight SpecialChar guifg=#56B1BB]]

end

return M
