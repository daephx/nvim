-- lsp_signature.nvim | LSP signature hint as you type
-- https://github.com/ray-x/lsp_signature.nvim
local signature_ok, signature = pcall(require, "lsp_signature")
if not signature_ok then
  return
end

signature.setup({
  hint_enable = false,
  hint_prefix = "■ ",
  handler_opts = {
    border = vim.g.border,
  },
})
