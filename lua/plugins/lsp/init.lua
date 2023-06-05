-- Neovim LSP Configuration (Language Server Protocol)
-- Setup native lsp using lspconfig helper plugin

-- Define default variables
local server_mpath = "plugins/lsp/settings"
local default_options = {
  capabilities = require("plugins.lsp.capabilities"),
  on_attach = require("plugins.lsp.attach"),
}

return {
  { -- Initialize language server configuration
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- Portable package manager for Neovim
      { "williamboman/mason.nvim" },
      -- bridges mason.nvim with the nvim-dap
      { "williamboman/mason-lspconfig.nvim" },
      -- Neovim setup for init.lua and plugin development
      { "folke/neodev.nvim", config = true },
      -- LSP support in Neovim for eclipse.jdt.ls
      { "mfussenegger/nvim-jdtls" },
      -- Tools for better development in rust
      { "simrat39/rust-tools.nvim" },
      -- Neovim extension for zk
      { "mickael-menu/zk-nvim" },
    },
    config = function()
      -- Initialize local lsp modules
      require("plugins.lsp.diagnostics")
      require("plugins.lsp.handlers")
      require("plugins.lsp.lspconfig")
      require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        ---@param server_name string
        function(server_name)
          local config -- Set default empty config table
          local namespace = table.concat({ server_mpath, server_name }, "/")
          local module_ok, module = pcall(require, namespace)
          if module_ok and type(module) == "table" then
            -- Set config to module return table if present
            config = type(module.setup) == "function" and module.setup({}) or module
          end
          -- Extend default_options with module return table
          config = vim.tbl_deep_extend("force", default_options, config or {})
          -- Initialize server with evaluated or empty config table
          require("lspconfig")[server_name].setup(config)
        end,

        ["rust_analyzer"] = function()
          require("plugins/lsp/settings/rust_analyzer")
        end,

        ["jdtls"] = function()
          require("plugins/lsp/settings/jdtls")
        end,

        ["zk"] = function()
          require("plugins/lsp/settings/zk")
        end,
      })
    end,
  },
  { -- Use Neovim as a language server
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- Collection of useful lua functions
      { "nvim-lua/plenary.nvim" },
      -- bridges mason.nvim with the null-ls
      { "jayp0521/mason-null-ls.nvim" },
    },
    config = function()
      require("plugins.lsp.null-ls")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      hint_enable = false,
      hint_prefix = "■ ",
      handler_opts = {
        border = vim.g.border,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Attach lsp_signature if client supports signature help",
        group = vim.api.nvim_create_augroup("LspSignatureAttach", {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client.supports_method("textDocument/signatureHelp") then
            local bufnr = ev.buf
            require("lsp_signature").on_attach({}, bufnr)
          end
        end,
      })
    end,
  },
}
