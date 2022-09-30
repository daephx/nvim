local M = {}

-- Initialize LSP capabilities
---@return table
M.initialize_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'additionalTextEdits',
      'detail',
      'documentation',
    },
  }
  return capabilities
end

return M
