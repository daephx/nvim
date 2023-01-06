local M = {}

-- Enable codelens
---@param client table
---@param bufnr integer
M.enable_code_lens = function(client, bufnr)
  if client.supports_method("textDocument/codeLens") then
    local augroup = vim.api.nvim_create_augroup("LspCodeLens", {})
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost", "CursorHold" }, {
      desc = "Refresh codelens for current buffer",
      buffer = bufnr,
      group = augroup,
      callback = vim.lsp.codelens.refresh,
    })
    vim.schedule(vim.lsp.codelens.refresh)
  end
end

return M
