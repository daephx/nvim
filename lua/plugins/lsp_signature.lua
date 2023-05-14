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

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Attach lsp_signature if client supports signature help",
  group = vim.api.nvim_create_augroup("LspSignatureAttach", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.supports_method("textDocument/signatureHelp") then
      local bufnr = ev.buf
      require("lsp_signature").on_attach({}, bufnr)
    end
  end,
})
