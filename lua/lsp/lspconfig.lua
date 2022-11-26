-- nvim-lspconfig | Quickstart configs for Nvim LSP
-- https://github.com/neovim/nvim-lspconfig
local lspconfig_ok, _ = pcall(require, 'lspconfig')
if not lspconfig_ok then
  local message = "Package 'lspconfig' not found, cannot setup language servers"
  vim.notify(message, vim.lsp.log_levels.ERROR, { title = 'Plugin Error' })
  return
end

-- Override lspconfig border options
require('lspconfig.ui.windows').default_options.border = 'single'
