-- Native LSP Configurations (Language Server Protocol)
local lspconfig_ok, _ = pcall(require, 'lspconfig')
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

-- Define globals
vim.g.disable_efm = true
vim.g.disable_null_ls = false

-- Import Locals
local capabilities = require('lsp.capabilities')
local diagnostics = require('lsp.diagnostics')
local handlers = require('lsp.handlers')
local icons = require('lsp.icons')
local utils = require('lsp.utils')

local M = {}

-- Initialize local settings
M.setup = function(opts)
  diagnostics.initialize_diagnostics()
  handlers.initialize_handlers()
  icons.initialize_icons()
  utils.initialize_servers({
    capabilities = capabilities.initialize_capabilities(),
    on_attach = handlers.default_attach,
    config_path = opts.config_path,
  })
end

return M
