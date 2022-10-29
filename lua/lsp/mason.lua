-- mason.nvim | Portable package manager for Neovim
-- https://github.com/williamboman/mason.nvim
local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  return
end

mason.setup({
  ui = {
    border = 'single',
  },
})

-- mason-lspconfig.nvim | makes it easier to use lspconfig with mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  return
end

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = { 'sumneko_lua' },
})
