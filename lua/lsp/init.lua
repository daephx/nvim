-- Native LSP Configurations (Language Server Protocol)
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  local msg = table.concat({
    'nvim-lsp failed to initialize',
    'Unable to locate dependency "lspconfig"',
  }, '\n')
  vim.notify(msg, vim.lsp.log_levels.ERROR, { title = 'Plugin Error' })
  return
end

-- Override lspconfig border options
require('lspconfig.ui.windows').default_options.border = 'single'

local installer_ok, installer = pcall(require, 'nvim-lsp-installer')
if not installer_ok then
  local msg = table.concat({
    'nvim-lsp failed to initialize',
    'Unable to locate dependency "nvim-lsp-installer"',
  }, '\n')
  vim.notify(msg, vim.lsp.log_levels.ERROR, { title = 'Plugin Error' })
  return
end

-- Configure nvim-lsp-installer before loading local server settings
local path = require('lspconfig.util').path
installer.setup({
  automatic_installation = true,
  ensure_installed = { 'sumneko_lua', 'bashls' },
  install_root_dir = path.join({ vim.fn.stdpath('data'), 'servers' }),
  ui = { border = 'single' },
})

local M = {}

-- Initialize local settings
M.setup = function(opts)
  local handlers = require('lsp.handlers')
  handlers.initialize_handlers()
  require('lsp.diagnostics').initialize_diagnostics()
  require('lsp.icons').initialize_icons()

  local capabilities = require('lsp.capabilities').initialize_capabilities()
  local on_attach = handlers.default_attach

  -- Get configured servers from lsp-installer
  local server_list = vim.tbl_map(function(client)
    return client.name
  end, installer.get_installed_servers())

  -- Loop server list for local config
  for _, server in pairs(server_list) do
    local namespace = table.concat({ opts.config_path, server }, '/')
    local module_ok, module = pcall(require, namespace)
    if module_ok then
      local server_config = {}
      if type(module) == 'table' then
        if type(module.setup) == 'function' then
          server_config = module.setup(capabilities, on_attach)
        end
      end

      -- Initialize configured servers
      lspconfig[server].setup(server_config)
    end
  end
end

return M
