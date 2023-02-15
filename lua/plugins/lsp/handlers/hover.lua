local M = {}

-- Enable diagnostic hover window at cursor position on CursorHold
---@param bufnr integer
M.enable_hover_diagnostics = function(bufnr)
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    buffer = bufnr,
    desc = "Show line diagnostics on cursor position in hover window",
    group = vim.api.nvim_create_augroup("LspHoverDiagnostics", {}),
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = vim.g.border,
        scope = "cursor",
      })
    end,
  })
end

return M
