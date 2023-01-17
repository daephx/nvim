local M = {}

-- Enable document symbol provider
---@param client table
---@param bufnr integer
M.enable_document_symbols = function(client, bufnr)
  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok then
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end
end

return M
