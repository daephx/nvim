local codelens = require("plugins.lsp.handlers.codelens")
local formatting = require("plugins.lsp.handlers.formatting")
local highlight = require("plugins.lsp.handlers.highlight")
local hover = require("plugins.lsp.handlers.hover")
local keymaps = require("plugins.lsp.keymaps")
local symbols = require("plugins.lsp.handlers.symbols")

-- Use an on_attach function to set LSP related actions for
-- when the language server attaches to the current buffer
---@param client table
---@param bufnr integer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- Enable Local handlers
  codelens.enable_code_lens(client, bufnr)
  formatting.enable_auto_formatting(client, bufnr)
  highlight.enable_document_highlighting(client, bufnr)
  hover.enable_hover_diagnostics(bufnr)
  keymaps.initialize_keymaps(client, bufnr)
  symbols.enable_document_symbols(client, bufnr)
end

return on_attach
