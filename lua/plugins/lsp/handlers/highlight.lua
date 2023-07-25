local M = {}

local augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

-- Set autocmd for the current buffer to enable and clear document highlight.
-- Only sets if the active client supported the textDocument/documentHighlight method.
---@param client table
---@param bufnr integer
M.enable_document_highlighting = function(client, bufnr)
  if client.supports_method("textDocument/documentHighlight") then
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      buffer = bufnr,
      desc = "Apply LSP document reference highlighting on CursorHold",
      group = augroup,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "BufLeave", "CursorMoved", "CursorMovedI", "InsertEnter" }, {
      buffer = bufnr,
      desc = "Disable LSP document reference highlighting on CursorMoved",
      group = augroup,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
