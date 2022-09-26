-- Native LSP Configurations (Language Server Protocol)
if not pcall(require, 'lspconfig') then
  local msg = table.concat({
    'nvim-lsp failed to initialize',
    'Unable to locate dependency "lspconfig"',
  }, '\n')
  vim.notify(msg, vim.lsp.log_levels.ERROR, { title = 'Plugin Error' })
  return
end

-- Define globals
vim.g.disable_efm = true
vim.g.disable_null_ls = false

local capabilities = require('lsp.capabilities')
local handlers = require('lsp.handlers')
local icons = require('lsp.icons')
local installer = require('lsp.installer')
local utils = require('lsp.utils')

local float_prefix = function(diagnostic)
  local res = icons.diagnostic_icons[diagnostic.severity]
  return string.format(' %s', res[1]), res[2]
end

-- Diagnostic Settings
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    focusable = false,
    header = { ' Diagnostics:', 'Normal' },
    show_header = true,
    source = 'always',
    prefix = float_prefix,
  },
  virtual_text = {
    prefix = '■',
    spacing = 1,
    severity = vim.diagnostic.severity.WARN,
    source = 'if_many',
  },
})

local M = {}

M.setup = function()
  -- Initialize diagnostic icons
  icons.initialize_icons()

  -- Override diagnostic hover window
  utils.override_diagnostic_float()

  -- Initialize LSP handlers
  handlers.initialize_handlers()

  -- Initialize language servers
  utils.initialize_servers({
    capabilities = capabilities.initialize_capabilities(),
    on_attach = handlers.default_attach,
    config_path = 'lua/lsp/servers',
  })
end

return M
