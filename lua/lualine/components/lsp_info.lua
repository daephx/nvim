-- Copyright (c) 2021-2026 daephx
-- MIT license, see LICENSE for more details.
local Component = require("lualine.component"):extend()

---Default component options
local _defaults = {
  separator = "",
  icon = { "" },
  -- Prevent the component from being displayed by some condition.
  -- Be default, the condition checks there is at least 1 active client
  condition = function()
    return #vim.lsp.get_clients({ bufnr = 0 }) > 0
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
      local venv_name = client.config.settings.python["venv_name"]
      if venv_name ~= nil then
        local system_path = vim.fn.exepath("python")
        local python_path = client.config.settings.python.venv_name
        if python_path ~= system_path then
          return string.format("%s (%s)", client.name, venv_name)
        end
      end
    end,
  },
}

---Configure default formatting for null-ls client to include source names
---@return string[]
local function get_nls_sources(options)
  local exclude = options.exclude or {}
  local parts = {}
  local ok, source_list = pcall(require, "null-ls.sources")
  if ok then
    local available = source_list.get_available(vim.bo.filetype)
    for _, source in pairs(available) do
      local excluded = vim.tbl_contains(exclude, source.name)
      if not excluded then
        table.insert(parts, source.name)
      end
    end
  end
  return parts
end

---Format a clients series of message
---@param title string
---@param message string
---@param percentage number
---@param done boolean
---@return lsp_progress.SeriesFormatResult
local function series_format(title, message, percentage, done)
  local parts = {}
  if type(title) == "string" and #title > 0 then
    table.insert(parts, title)
  end
  if type(message) == "string" and #message > 0 then
    table.insert(parts, message)
  end
  if percentage and (#parts > 0) then
    table.insert(parts, string.format("(%.0f%%)", percentage))
  end
  return { msg = table.concat(parts, " "), done = done }
end

---Format a single client's progress
---@param client_name string
---@param spinner string
---@param series_messages table
---@return string|nil
local function client_format(client_name, spinner, series_messages)
  if #series_messages == 0 then
    return nil
  end

  local active_msgs = {}
  local any_active = false

  for _, series in ipairs(series_messages) do
    local msg = (series.msg or ""):gsub("%.%.%.", "…")
    if msg == "" then
      msg = "Processing"
    end
    if not series.done then
      any_active = true
      table.insert(active_msgs, msg)
    elseif not any_active and #active_msgs == 0 then
      -- If we haven't seen any active yet, store the first done message as fallback
      -- (so we have something to show when all are done)
      table.insert(active_msgs, msg)
    end
  end

  -- If nothing was collected (shouldn't happen), bail
  if #active_msgs == 0 then
    return nil
  end

  -- If there are no active tasks, all are done, show checkmark
  if not any_active then
    spinner = "✓"
  end

  -- First message is primary, optionally with extra count
  local primary_msg = active_msgs[1]
  local extra_part = (#active_msgs > 1) and string.format("+%d more, ", #active_msgs - 1) or ""

  return string.format("%s%s %s [%s]", extra_part, primary_msg, spinner, client_name)
end

---Initialize component
---@param options table
function Component:init(options)
  Component.super.init(self, options)
  options.colors = self.extend(self, "colors")
  self.options = vim.tbl_deep_extend("force", _defaults, options)

  -- Initialize compat for default null-ls source formatter
  if self.options.format_clients["null-ls"] == nil then
    self.options.format_clients["null-ls"] = function()
      local sources = get_nls_sources(options)
      local separator = (" %s "):format(self.options.separator)
      return table.concat(sources, separator)
    end
  end

  -- Skip init lsp_progress if not available
  local ok, lsp_progress = pcall(require, "lsp-progress")
  if not ok then
    return
  end

  -- Configure lsp_progress
  ---@type lsp_progress.Configs
  lsp_progress.setup({
    decay = 1200,
    client_format = client_format,
    series_format = series_format,
    format = function(client_messages)
      for _, msg in pairs(client_messages) do
        if msg then
          return msg
        end
      end
      return nil
    end,
  })
end

---Format client names based on component options
---@param client vim.lsp.Client
---@param client_map table<string, string|fun(vim.lsp.Client): string>
---@return string
local function format_client_name(client, client_map)
  local client_name = client.name
  for key, value in pairs(client_map) do
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
---@return table
local function get_client_names(options)
  local parts = {}
  local active_clients = vim.lsp.get_clients({ bufnr = 0 })
  local exclude = options.exclude
  local format_clients = options.format_clients
  for _, client in ipairs(active_clients) do
    local is_excluded = vim.list_contains(exclude, client.name)
    if client and not is_excluded then
      local client_name = format_client_name(client, format_clients)
      table.insert(parts, client_name)
    end
  end
  return parts
end

---Update component
---@return string|nil
function Component:update_status()
  if package.loaded["lsp-progress"] then
    local progress = require("lsp-progress").progress()
    if progress ~= nil then
      return progress
    end
  end

  -- Fallback: show list of active client names (if any)
  local clients = get_client_names(self.options)
  local separator = (" %s "):format(self.options.separator)
  if #clients > 0 then
    return table.concat(clients, separator)
  end
  return ""
end

return Component
