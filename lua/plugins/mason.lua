-- mason.nvim | Portable package manager for Neovim
-- https://github.com/williamboman/mason.nvim

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonLog", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>pm", "<cmd>Mason<CR>", desc = "Show mason" },
    },
    opts = {
      ui = {
        height = 0.8,
        border = vim.g.border,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_installation = false,
      ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "emmet_ls",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "taplo",
        "yamlls",
      },
    },
  },
  {
    "jayp0521/mason-null-ls.nvim",
    cmd = { "NullLsInstall", "NullLsUninstall" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
      automatic_installation = false,
      ensure_installed = {
        "black",
        "eslint_d",
        "isort",
        "luacheck",
        "markdownlint",
        "prettier",
        "ruff",
        "shfmt",
        "stylua",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      automatic_installation = false,
      automatic_setup = true,
      ensure_installed = {},
    },
  },
}
