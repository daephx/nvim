-- mason.nvim | Portable package manager for Neovim
-- https://github.com/williamboman/mason.nvim

---@type LazyPluginSpec[]
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
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
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
      handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        ---@param server_name string
        function(server_name)
          -- Define default variables
          local server_mpath = "plugins/lsp/servers"
          local default_options = {
            capabilities = require("plugins.lsp.capabilities"),
            on_attach = require("plugins.lsp.attach"),
          }
          local namespace = table.concat({ server_mpath, server_name }, "/")
          local _, module = pcall(require, namespace)
          module = type(module) == "table" and module or {}
          local config = vim.tbl_deep_extend("force", default_options, module or {})
          require("lspconfig")[server_name].setup(config)
        end,

        ["rust_analyzer"] = function()
          require("plugins/lsp/settings/rust_analyzer")
        end,

        ["jdtls"] = function()
          require("plugins/lsp/settings/jdtls")
        end,
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
        "black",
        "isort",
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
          local adapters_path = "plugins/dap/adapters"
          local namespace = table.concat({ adapters_path, config.name }, "/")
          local _, module = pcall(require, namespace)
          module = type(module) == "table" and module or {}
          config = vim.tbl_deep_extend("force", config, module or {})
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
