-- mason.nvim | Portable package manager for Neovim
-- https://github.com/williamboman/mason.nvim
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

mason.setup({
  ui = {
    height = 0.8,
    border = vim.g.border,
  },
})

-- mason-lspconfig.nvim | makes it easier to use lspconfig with mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_ok then
  mason_lspconfig.setup({
    automatic_installation = false,
    ensure_installed = {
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "emmet_ls",
      "gopls",
      "html",
      "jdtls",
      "jsonls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "taplo",
      "yamlls",
      "zk",
    },
  })
end

-- mason-null-ls.nvim | mason-null-ls bridges mason.nvim with the null-ls plugin
-- https://github.com/jayp0521/mason-null-ls.nvim
local mason_null_ok, mason_null = pcall(require, "mason-null-ls")
if mason_null_ok then
  mason_null.setup({
    automatic_installation = false,
    ensure_installed = {
      "black",
      "eslint_d",
      "flake8",
      "isort",
      "luacheck",
      "markdownlint",
      "prettier",
      "shfmt",
      "stylua",
    },
  })
end

-- mason-nvim-dap.nvim | mason-nvim-dap bridges mason.nvim with the nvim-dap plugin
-- https://github.com/jay-babu/mason-nvim-dap.nvim
local mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
if mason_dap_ok then
  mason_dap.setup({
    automatic_installation = false,
    automatic_setup = true,
    ensure_installed = {},
  })
end
