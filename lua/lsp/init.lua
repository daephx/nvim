-- Native LSP Configurations (Language Server Protocol)
if not pcall(require, 'lspconfig') then
  local msg = table.concat({
    'nvim-lsp failed to initialize',
    'Unable to locate dependency "lspconfig"',
  }, '\n')
  vim.notify(msg, vim.lsp.log_levels.ERROR, { title = 'Plugin Error' })
  return
end

local M = {}

-- Define globals
vim.g.disable_efm = true
vim.g.disable_null_ls = false

-- Import Locals
local capabilities = require('lsp.capabilities')
local diagnostics = require('lsp.diagnostics')
local handlers = require('lsp.handlers')
local icons = require('lsp.icons')
local utils = require('lsp.utils')

-- Initialize local settings
M.setup = function(opts)
  diagnostics.initialize_diagnostics()
  handlers.initialize_handlers()
  icons.initialize_icons()
  utils.override_diagnostic_float()
  utils.override_installer_float()
  utils.initialize_servers({
    capabilities = capabilities.initialize_capabilities(),
    on_attach = handlers.default_attach,
    config_path = opts.config_path,
  })
end

return M
