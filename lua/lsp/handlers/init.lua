-- lsp.handlers

local M = {}

local codelens = require('lsp.handlers.codelens')
local formatting = require('lsp.handlers.formatting')
local highlight = require('lsp.handlers.highlight')
local hover = require('lsp.handlers.hover')
local keymaps = require('lsp.keymaps')
local signature = require('lsp.handlers.signature')

-- Use an on_attach function to set LSP related actions for
-- when the language server attaches to the current buffer
M.default_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Enable Local handlers
  codelens.enable_code_lens(client, bufnr)
  formatting.enable_auto_formatting(client, bufnr)
  highlight.enable_document_highlighting(client, bufnr)
  hover.enable_hover_diagnostics(bufnr)
  keymaps.initialize_keymaps(client, bufnr)
  -- signature.enable_signature_help(client, bufnr)
end

-- Define LSP Handlers
M.initialize_handlers = function()
  -- vim.lsp.handlers['textDocument/definition'] = utils.goto_definition('vsplit')
end

return M
