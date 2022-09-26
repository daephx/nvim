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

local capabilities = require('lsp.capabilities')
local diagnostics = require('lsp.diagnostics')
local handlers = require('lsp.handlers')
local icons = require('lsp.icons')
local installer = require('lsp.installer')
local utils = require('lsp.utils')

M.setup = function()
  icons.initialize_icons()
  diagnostics.initialize_diagnostics()
  utils.override_diagnostic_float()
  handlers.initialize_handlers()
  utils.initialize_servers({
    capabilities = capabilities.initialize_capabilities(),
    on_attach = handlers.default_attach,
    config_path = 'lua/lsp/servers',
  })
end

return M
