-- lsp/handlers/signature.lua

-- Configure vim.lsp.handler
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
  close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
})

local M = {}

-- Show signature help on cursor position in hover window
---@param client table
---@param bufnr integer
M.enable_signature_help = function(client, bufnr)
  if client.supports_method('textDocument/signatureHelp') then
    -- TODO: Causes error prompts in &diff, gitcommit and other unsupported filetypes
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      desc = 'Show signature help on cursor position in hover window',
      callback = function()
        vim.lsp.buf.signature_help(nil, { scope = 'cursor' })
      end,
    })
  end
end

return M
