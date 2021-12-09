
-- Set signs
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapStopped', { text = '◯', texthl = 'Number' })

local M = {}

M.load_modules = function()
  -- require('dap.python')
end

return M
