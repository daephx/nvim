-- mason.nvim | Portable package manager for Neovim
-- https://github.com/williamboman/mason.nvim

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate" },
    build = ":MasonUpdate",
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
        "rust_analyzer",
        "taplo",
        "yamlls",
      },
    },
  },
  {
    "jayp0521/mason-null-ls.nvim",
    opts = {
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
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = false,
      automatic_setup = true,
      ensure_installed = {},
    },
  },
}
