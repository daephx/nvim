-- Neovim LSP Configuration (Language Server Protocol)
-- Setup native lsp using lspconfig helper plugin

---@type LazyPluginSpec[]
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
      -- LSP support in Neovim for eclipse.jdt.ls
      { "mfussenegger/nvim-jdtls" },
      -- Tools for better development in rust
      { "simrat39/rust-tools.nvim" },
      -- Neovim extension for zk
      { "mickael-menu/zk-nvim" },
    },
    init = function()
      -- Initialize diagnostic settings
      require("plugins.lsp.diagnostics")

      -- Prevent high cpu usage due to new watch files implementation.
      -- NOTE: https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        -- disable lsp watcher. Too slow on linux
        wf._watchfunc = function()
          return function() end
        end
      end
    end,
    config = function()
      -- Define default variables
      local server_mpath = "plugins/lsp/settings"
      local default_options = {
        capabilities = require("plugins.lsp.capabilities"),
        on_attach = require("plugins.lsp.attach"),
      }

      -- Override lspconfig default window options
      local windows = require("lspconfig.ui.windows")
      windows.default_options = { border = vim.g.border }

      -- Initialize local lsp modules
      require("plugins.lsp.handlers")
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
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- Collection of useful lua functions
      { "nvim-lua/plenary.nvim" },
      -- bridges mason.nvim with the null-ls
      { "jayp0521/mason-null-ls.nvim" },
      -- Extra sources for none-ls.nvim
      { "nvimtools/none-ls-extras.nvim" },
      -- Luacheck diagnostics source for none-ls.nvim
      { "gbprod/none-ls-luacheck.nvim" },
    },
    config = function()
      local null_ls = require("null-ls")
      local opts = require("plugins.lsp.null-ls")
      null_ls.setup(opts)
    end,
  },
  { -- Faster LuaLS setup for Neovim
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "lazy.nvim" },
      },
    },
  },
  { -- LSP signature hint as you type
    "ray-x/lsp_signature.nvim",
    event = { "LspAttach" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      hint_enable = false,
      hint_prefix = "■ ",
      handler_opts = {
        border = vim.g.border,
      },
    },
  },
  { -- IDE-like code action indicator
    "kosayoda/nvim-lightbulb",
    cond = vim.fn.has("nvim-0.10") == 0,
    event = { "LspAttach" },
    opts = {
      autocmd = { enabled = true },
    },
  },
}
