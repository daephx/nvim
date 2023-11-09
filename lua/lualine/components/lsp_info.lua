-- Copyright (c) 2021-2023 daephx
-- MIT license, see LICENSE for more details.
local lsp_info = require("lualine.component"):extend()

local default_options = {
  max_size = -1,
  separator = "",
  icon = { "" },
  -- Prevent the component from being displayed by some condition.
  -- Be default, the condition checks there is at least 1 active client
  condition = function()
    return vim.lsp.get_active_clients({ bufnr = 0 }) > 0
  end,
  -- List of excluded clients and null-ls sources.
  exclude = {
    "dictionary",
    "gitsigns",
  },
  -- Map of client names to replace
  -- First item is the Matching name while the second is what to replace with.
  -- Accepts either a string or function.
  format_clients = {
    ["pyright"] = function(client)
      -- Check if python lsp and has virtual environment
      if client.config.settings.python["venv_name"] ~= nil then
        local venv_name = client.config.settings.python.venv_name
        return string.format("%s(%s)", client.name, venv_name)
      end
    end,
  },
}

---Return filtered list of buffer attached null-ls source names
---@param exclude table
---@return table
local function null_sources(exclude)
  local _, sources = pcall(function()
    local ret = {}
    local nls_sources = require("null-ls.sources")
    local available = nls_sources.get_available(vim.bo.filetype)
    for _, client in pairs(available) do
      local excluded = vim.tbl_contains(exclude, client.name)
      local registered = vim.tbl_contains(ret, client.name)
      if not excluded and not registered then
        table.insert(ret, client.name)
      end
    end
    return ret
  end)
  return sources
end

---Helper for get_client_names to evaluate the client names from options table
---@param client table
---@return string
local function eval_client_name(client, names)
  local client_name = client.name
  for key, value in pairs(names) do
    local new_name
    if client_name == key then
      if type(value) == "function" then
        new_name = value(client)
      elseif type(value) == "string" then
        new_name = value
      end
      if new_name and new_name ~= "" then
        client_name = new_name
      end
    end
  end
  return client_name
end

---Modify client name for style or to add extra metadata
---@param options table
---@return table
local function get_client_names(options)
  local clients = {}
  local active_clients = vim.lsp.get_active_clients({ bufnr = 0 })
  for _, client in pairs(active_clients) do
    local excluded = vim.tbl_contains(options.exclude, client.name)
    if client and client.name == "null-ls" then
      local sources = null_sources(options.exclude)
      clients = vim.list_extend(sources, clients)
    elseif client and client.name ~= "" and not excluded then
      local client_name = eval_client_name(client, options.format_clients)
      table.insert(clients, client_name)
    end
  end
  return clients
end

---Initialize component
---@param options table
function lsp_info:init(options)
  lsp_info.super.init(self, options)
  options.colors = self.extend(self, "colors")
  self.options = vim.tbl_deep_extend("force", default_options, self.options or {})
end

---Update component
---@return string|nil
function lsp_info:update_status()
  local clients = get_client_names(self.options)
  local separator = (" %s "):format(self.options.separator)
  local plugin_ok, lsp_progress = pcall(require, "lsp-progress")
  if not plugin_ok then
    return table.concat(clients, separator)
  end

  -- Use plugins provided progress method if available
  return lsp_progress.progress({
    max_size = self.options.max_size,
    format = function(messages)
      if #messages > 0 then
        return table.concat(messages, " ")
      end
      if #clients > 0 then
        return table.concat(clients, separator)
      end
    end,
  })
end

return lsp_info
