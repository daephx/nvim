-- lsp/handlers/diagnostics.lua

local icons = require('plugins.lsp.icons')

local sources = {
  { 'Lua Diagnostics.', 'Sumneko' },
  { 'Lua Syntax Check.', 'Sumneko' },
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
  local name = rename_diagnostic_source(diagnostic)
  return string.format('%s: %s ', name, diagnostic.message)
end

local float_prefix = function(diagnostic)
  local tbl = icons.diagnostics[diagnostic.severity]
  return string.format('%s ', tbl.sign), tbl.hl
end

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    focusable = false,
    format = format,
    header = { 'ﴫ Diagnostics:', 'Label' },
    prefix = float_prefix,
    scope = 'line',
    show_header = true,
    source = false,
  },
  virtual_text = {
    prefix = '■',
    spacing = 1,
    source = false,
    format = format,
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
})
