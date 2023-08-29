-- Define LSP handlers to be exported globally

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = vim.g.border,
  close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
  focusable = false,
  silent = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = vim.g.border,
})

local definition = require("plugins.lsp.handlers.definition")
vim.lsp.handlers["textDocument/definition"] = definition.goto_definition
