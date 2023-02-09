local M = {}

-- Show signature help on cursor position in hover window
---@param client table
---@param bufnr integer
M.enable_signature_help = function(client, bufnr)
  if client.supports_method("textDocument/signatureHelp") then
    -- Enable lsp_signature plugin it is installed
    local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
    if lsp_signature_ok then
      lsp_signature.on_attach({}, bufnr)
    end
  end
end

return M
