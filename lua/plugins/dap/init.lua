-- DAP | Debug Adapter Protocol

-- Define Debugging highlights
vim.cmd('highlight link debugBreakpoint DiagnosticsHint')

-- Define Debugging signs
vim.fn.sign_define('DapBreakpoint', {text=' ', texthl='debugBreakpoint'})
vim.fn.sign_define('DapBreakpointCondition', {text=' ', texthl='DiagnosticWarn'})
vim.fn.sign_define('DapBreakpointRejected', {text=' ', texthl='DiagnosticError'})
vim.fn.sign_define('DapLogPoint', {text=' ', texthl='debugBreakpoint'})
vim.fn.sign_define('DapStopped', {text='●', texthl='DiagnosticsHint'})


local dap = require('dap')

dap.listeners.after['event_initialized']['dapui'] = function()
  require('dapui').open()
end
dap.listeners.after['event_terminated']['dapui'] = function()
  require('dapui').close()
end


-- Languages defined here will be looked for in the plugin.dap module,
-- Any lua script with the coorisponding name will be loaded if found.
-- i.e. lua/plugins/dap/python.lua

local languages = {
  -- "cpp",
  -- "cs",
  -- "go",
  -- "ruby",
  -- "lua",
  -- "python",
  -- "rust",
  -- "javascript",
}

local M = {}

M.config = function()
  -- initialize adapters/configs for languages
  for _, lang in pairs(languages) do
    if not pcall(require, 'plugins.dap.' .. lang) then
      error("DAP: Config for " .. lang .. " is not defined!")
      return
    end
  end
end

return M
