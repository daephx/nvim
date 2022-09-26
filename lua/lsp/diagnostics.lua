-- lsp.diagnostics

local M = {}

local icons = require('lsp.icons')

local sources = {
  { 'Lua Diagnostics.', 'Sumneko' },
}

-- Allow for replacing diagnostic source from matching name
local rename_diagnostic_source = function(diagnostic)
  for _, item in pairs(sources) do
    if diagnostic.source == item[1] then
      return item[2]
    end
  end

  return diagnostic.source
end

local format = function(diagnostic)
  local message = string.format(
    '%s, %s: %s ',
    rename_diagnostic_source(diagnostic),
    diagnostic.code,
    diagnostic.message
  )
  return message
end

local float_prefix = function(diagnostic)
  local res = icons.diagnostic_icons[diagnostic.severity]
  return string.format(' %s', res[1]), res[2]
end

local defaults = {
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    focusable = false,
    header = { ' Diagnostics:', 'Normal' },
    show_header = true,
    source = 'always',
    prefix = float_prefix,
  },
  virtual_text = {
    prefix = '■',
    spacing = 1,
    severity = vim.diagnostic.severity.WARN,
    source = 'if_many',
  },
}

M.initialize_diagnostics = function()
  vim.diagnostic.config(defaults)
end

return M
