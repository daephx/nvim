-- Define custom LSP handlers with global export
-- TODO: handlers are deprecated and should be removed in Neovim 0.13.

-- Skip loading in newer versions of Neovim (0.11+).
if vim.fn.has("nvim-0.11") == 1 then
  return
end

-- FIXME: Custom "goto definition" handler for split window not working.
-- local definition = require("plugins.lsp.handlers.definition")
-- vim.lsp.handlers["textDocument/definition"] = definition.goto_definition

-- Hover handler with custom border style
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = vim.g.border,
})

-- NOTE: Doesn't seem to work with signatureHelp plugin
-- Signature help handler with custom border and close events
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = vim.g.border,
  close_events = { "BufHidden", "CursorMoved", "CursorMovedI", "InsertCharPre" },
  focusable = false,
  silent = true,
})
