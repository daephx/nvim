-- Copyright (c) 2021-2023 daephx
-- MIT license, see LICENSE for more details.
local lsp_clients = require("lualine.component"):extend()

local default_options = {
  condition = function()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    return #clients > 0
  end,
  separator = "",
  icon = { "" },
  exclude_sources = { "gitsigns" },
}

function lsp_clients:init(options)
  lsp_clients.super.init(self, options)
  options.colors = self.extend(self, "colors")
  self.options = vim.tbl_deep_extend("force", default_options, self.options or {})
end

-- Return filtered list of buffer attached null-ls source names
---@param exclude table
---@return table
local null_sources = function(exclude)
  local _, sources = pcall(function()
    local ret = {}
    local sources = require("null-ls.sources")
    local available = sources.get_available(vim.bo.filetype)
    for _, client in pairs(available) do
      local is_exclude = vim.tbl_contains(exclude, client.name)
      local is_present = vim.tbl_contains(ret, client.name)
      if not is_exclude and not is_present then
        table.insert(ret, client.name)
      end
    end
    return ret
  end)
  return sources
end

-- Modify client name for style or to add extra metadata
---@param client table
---@return string
local format_client_name = function(client)
  if client.name == "pyright" then
    -- Check if python lsp and has virtual environment
    if client.config.settings.python["venv_name"] ~= nil then
      local venv_name = client.config.settings.python.venv_name
      return string.format("%s(%s)", client.name, venv_name)
    end
  end
  return client.name
end

function lsp_clients:update_status()
  local clients = {}
  -- TODO: Deprecation warning v0.10: Use vim.lsp.get_clients({ bufnr = 0 })
  local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local exclude = self.options.exclude_sources
  for _, client in pairs(buf_clients) do
    if client.name == "null-ls" then
      clients = vim.list_extend(null_sources(exclude), clients)
    elseif not vim.tbl_contains(exclude, client.name) then
      table.insert(clients, format_client_name(client))
    end
  end

  if next(clients) ~= nil then
    local sep = (" %s "):format(default_options.separator)
    return table.concat(clients, sep)
  else
    return ""
  end
end

return lsp_clients
