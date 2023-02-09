-- lsp_signature.nvim | LSP signature hint as you type
-- https://github.com/ray-x/lsp_signature.nvim
local signature_ok, signature = pcall(require, "lsp_signature")
if not signature_ok then
  return
end

signature.setup({
  floating_window_above_cur_line = false,
  hint_enable = false,
  hint_prefix = "■ ",
  max_width = 100,
  handler_opts = {
    border = "single",
  },
})
