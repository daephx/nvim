-- bashls: A language server for Bash
-- https://github.com/bash-lsp/bash-language-server

vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  desc = "Disable bashls diagnostics for .env files",
  group = vim.api.nvim_create_augroup("LspEnvFileDiagnostics", {}),
  pattern = ".env*",
  callback = function(ev)
    vim.diagnostic.disable(ev.buf)
  end,
})

return {}
