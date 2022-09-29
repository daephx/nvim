-- lsp.handlers

local M = {}

local formatting = require('lsp.handlers.formatting')
local hover = require('lsp.handlers.hover')
local keymaps = require('lsp.keymaps')
local utils = require('lsp.utils')
local signature = require('lsp.handlers.signature')

-- Use an on_attach function to set LSP related actions for
-- when the language server attaches to the current buffer
M.default_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  formatting.enable_auto_formatting(client, bufnr)
  utils.enable_document_highlighting(client, bufnr)
  hover.enable_hover_diagnostics(bufnr)

  -- Enable LSP Mappings
  keymaps.initialize_keymaps(client, bufnr)
  -- signature.enable_signature_help(client, bufnr)
end

-- Define LSP Handlers
M.initialize_handlers = function()
  -- vim.lsp.handlers['textDocument/definition'] = utils.goto_definition('vsplit')
end

return M
