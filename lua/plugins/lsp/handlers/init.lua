-- Define lsp handlers to be exported globally

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
  close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

-- vim.lsp.handlers['textDocument/rename'] = require('plugins.lsp.handlers.rename').incremental_rename
-- vim.lsp.handlers['textDocument/rename'] = vim.lsp.buf.rename.float

vim.lsp.handlers['textDocument/definition'] = require('plugins.lsp.handlers.definition').goto_definition()
-- vim.lsp.handlers['textDocument/documentSymbol'] = utils.lsp_symbols_handler()
-- vim.lsp.handlers['textDocument/implementation'] = utils.location_handler('LSP Implementations', 'implementations')
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})
-- vim.lsp.handlers['textDocument/references'] = utils.location_handler()
-- vim.lsp.handlers['textDocument/typeDefinition'] = utils.location_handler('LSP Type Definitions', 'typeDefinitions')
-- vim.lsp.handlers['workspace/symbol'] = utils.lsp_symbols_handler()
