
-- Set signs
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapStopped', { text = '◯', texthl = 'Number' })


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
