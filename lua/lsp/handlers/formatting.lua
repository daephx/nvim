local M = {}

M.format_document = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      return client.name == 'null-ls'
    end,
  })
end

-- Enable auto-formatting on BufWritePre
M.enable_auto_formatting = function(client, bufnr)
  local group = vim.api.nvim_create_augroup('LspFormatting', {})
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_user_command('Format', 'do User LspFormatting', {})
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Apply Auto-formatting for to document on save',
      buffer = bufnr,
      group = group,
      callback = function()
        M.format_document(bufnr)
      end,
    })
  end
end

return M
