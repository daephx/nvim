-- lsp.utils

local M = {}

local lspconfig = require('lspconfig')

local get_installed_servers = function()
  local lsp_installer = require('nvim-lsp-installer')
  -- Get configured servers from lsp-installer
  local server_list = vim.tbl_map(function(client)
    return client.name
  end, lsp_installer.get_installed_servers())

  -- insert null-ls if available
  if pcall(require, 'null-ls') then
    table.insert(server_list, 'null-ls')
  end

  return server_list
end

M.initialize_servers = function(opts)
  local server_list = get_installed_servers()

  -- Loop server list for local config
  for _, server in pairs(server_list) do
    local namespace = table.concat({ opts.config_path, server }, '/')
    local _, module = pcall(require, namespace)

    local config = {}
    if type(module) == 'table' then
      if type(module.setup) == 'function' then
        config = module.setup(opts.capabilities, opts.on_attach)
      end
    end

    -- Set lspconfig from module files
    -- Exclude null-ls as it shouldn't be enabled via lspconfig
    if server ~= 'null-ls' then
      lspconfig[server].setup(config)
    end
  end
end

return M
