local M = {}

-- Highlight references under cursor
---@param client table
---@param bufnr integer
M.enable_document_highlighting = function(client, bufnr)
  if client.supports_method('textDocument/documentHighlight') then
    local augroup = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })
    vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
      desc = 'Link LSP document reference highlighting to IncSearch',
      group = augroup,
      callback = function()
        local opts = { link = 'IncSearch', bold = true }
        vim.api.nvim_set_hl(0, 'LspReferenceRead', opts)
        vim.api.nvim_set_hl(0, 'LspReferenceText', opts)
        vim.api.nvim_set_hl(0, 'LspReferenceWrite', opts)
      end,
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      desc = 'Apply LSP documment reference highlighting on CursorHold',
      group = augroup,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'CursorMovedI' }, {
      buffer = bufnr,
      desc = 'Disable LSP documment reference highlighting on CursorMoved',
      group = augroup,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
