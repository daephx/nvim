-- Neovim LSP Configuration (Language Server Protocol)

-- Initialize local lsp modules
require('lsp.lspconfig')

local M = {}

-- Initialize local settings
M.setup = function(opts)
  local handlers = require('lsp.handlers')
  handlers.initialize_handlers()
  require('lsp.diagnostics').initialize_diagnostics()
  require('lsp.icons').initialize_icons()

  local capabilities = require('lsp.capabilities').initialize_capabilities()
  local on_attach = handlers.default_attach

  -- Initialize null-ls
  require('lsp.null-ls').setup(nil, on_attach)

  -- Get list of available servers
  local mason_lspconfig = require('mason-lspconfig')
  local server_list = mason_lspconfig.get_available_servers()

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
      require('lspconfig')[server].setup(server_config)
    end
  end
end

return M
