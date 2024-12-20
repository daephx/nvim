local M = {}

---Register autocmd for LSP codelens
---@param client vim.lsp.Client
---@param bufnr integer
M.enable_code_lens = function(client, bufnr)
  local group = vim.api.nvim_create_augroup("LspCodeLens", {})
  if client.supports_method("textDocument/codeLens") then
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      desc = "Refresh codelens for current buffer",
      group = group,
      callback = function(ev)
        vim.lsp.codelens.refresh({ bufnr = ev.buf })
      end,
    })
  end
end

return M
