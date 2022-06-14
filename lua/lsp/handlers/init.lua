-- lsp.handlers

local M = {}

local lsp_formatting = require('lsp.handlers.formatting')
local lsp_keymaps = require('lsp.keymaps')
local lsp_utils = require('lsp.utils')

-- Use an on_attach function to set LSP related actions for
-- when the language server attaches to the current buffer
M.default_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  lsp_formatting.enable_auto_formatting(client, bufnr)
  lsp_utils.enable_document_highlighting(client, bufnr)
  lsp_utils.enable_hover_diagnostics(bufnr)

  -- Enable LSP Mappings
  lsp_keymaps.initialize_keymaps(client, bufnr)
end

-- Define LSP Handlers
M.initialize_handlers = function()
  -- vim.lsp.handlers['textDocument/definition'] = lsp_utils.goto_definition('vsplit')
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )
end

return M
