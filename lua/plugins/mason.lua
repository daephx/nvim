-- mason.nvim | Portable package manager for Neovim
-- https://github.com/williamboman/mason.nvim

---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = { "VeryLazy" },
    cmd = {
      "Mason",
      "MasonLog",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonUpdate",
    },
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
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "emmet_ls",
        "eslint",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "ruff",
        "taplo",
        "yamlls",
      },
    },
  },
  {
    "jayp0521/mason-null-ls.nvim",
    cmd = { "NullLsInstall", "NullLsUninstall" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
      ensure_installed = {
        "markdownlint",
        "prettier",
        "selene",
        "shfmt",
        "stylua",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
      automatic_setup = true,
      ensure_installed = {},
      handlers = {
        function(config)
          local namespace = table.concat({ "plugins/dap/adapters", config.name }, "/")
          local _, module = pcall(require, namespace)
          module = type(module) == "table" and module or {}
          config = vim.tbl_deep_extend("force", config, module or {})
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
