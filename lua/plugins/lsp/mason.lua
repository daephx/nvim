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
if mason_lspconfig_ok then
  mason_lspconfig.setup({
    automatic_installation = true,
    ensure_installed = {
      'bashls',
      'clangd',
      'cssls',
      'dockerls',
      'emmet_ls',
      'gopls',
      'html',
      'jdtls',
      'jsonls',
      'pyright',
      'rust_analyzer',
      'sumneko_lua',
      'yamlls',
      'zk',
    },
  })
end

-- mason-null-ls.nvim | mason-null-ls bridges mason.nvim with the null-ls plugin
-- https://github.com/jayp0521/mason-null-ls.nvim
local mason_null_ok, mason_null = pcall(require, 'mason-null-ls')
if mason_null_ok then
  mason_null.setup({
    automatic_installation = true,
    ensure_installed = {
      'markdownlint',
      'prettier',
      'shfmt',
      'stylua',
    },
  })
end
