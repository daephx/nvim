local lsp_clients = require("lualine.component"):extend()

-- Modify client name for style or to add extra metadata
---@param client table
---@return string
local format_client_name = function(client)
  if client.name == "pyright" then
    -- Check if python lsp and has virtual environment
    if client.config.settings.python["venv_name"] ~= nil then
      local venv_name = client.config.settings.python.venv_name
      return string.format("%s (%s)", client.name, venv_name)
    end
  end
  return client.name
end

local default_options = {
  condition = function()
    return #vim.lsp.buf_get_clients() > 0
  end,
  icon = {
    "",
    align = "right",
    color = { fg = "Gray", gui = "bold" },
  },
}

function lsp_clients:init(options)
  lsp_clients.super.init(self, options)
  options.colors = self.extend(self, "colors")
  self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)
end

function lsp_clients:update_status()
  local next = next
  local clients = {}
  local buf_clients = vim.lsp.buf_get_clients()
  for _, client in pairs(buf_clients) do
    table.insert(clients, format_client_name(client))
  end
  -- If list is empty return empty string
  if next(clients) == nil then
    return ""
  end
  return table.concat(clients, "  ")
end

return lsp_clients
