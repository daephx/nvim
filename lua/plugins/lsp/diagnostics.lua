-- lsp/handlers/diagnostics.lua
local icons = require("config.icons")

local client_map = {
  { "Lua Diagnostics.", "LuaLS" },
  { "Lua Syntax Check.", "LuaLS" },
}

-- Allow for replacing diagnostic source from matching name
---@param diagnostic table
---@return string
local rename_diagnostic_source = function(diagnostic)
  for _, item in pairs(client_map) do
    if diagnostic.source == item[1] then
      return item[2]
    end
  end
  return diagnostic.source
end

-- Format diagnostic virtual text message
---@param diagnostic table
---@return string
local format = function(diagnostic)
  local name = rename_diagnostic_source(diagnostic)
  return string.format("%s: %s ", name, diagnostic.message)
end

-- Format diagnostic floating window prefix
---@param diagnostic table
---@return string, string
local float_prefix = function(diagnostic)
  local tbl = icons.diagnostics[diagnostic.severity]
  return string.format("%s ", tbl.text), tbl.hl
end

-- Apply neovim lsp diagnostic configs
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = vim.g.border,
    focusable = false,
    format = format,
    header = { "󰠭 Diagnostics:", "Label" },
    prefix = float_prefix,
    scope = "line",
    show_header = true,
    source = false,
  },
  virtual_text = {
    prefix = "■",
    spacing = 1,
    source = false,
    format = format,
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
})
