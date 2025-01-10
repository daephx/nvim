-- Neovim LSP Configuration (Language Server Protocol)
-- Setup native lsp using lspconfig helper plugin

---Custom LSP client config type.
---HACK: Overrides required `cmd` field for type completion, as `cmd` is
---provided by plugins like lspconfig and mason.
---@class config.lsp.ClientConfig: vim.lsp.ClientConfig
---@field cmd any? See: @type vim.lsp.ClientConfig for more information.
---@field flags config.lsp.Client.Flags?

---See: @type vim.lsp.Client.Flags for more information.
---@class config.lsp.Client.Flags: vim.lsp.Client.Flags
---@field debounce_text_changes any?
---@field exit_timeout any?

---@type LazySpec
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
    },
    config = function()
      -- Override lspconfig default window options
      local windows = require("lspconfig.ui.windows")
      windows.default_options = { border = vim.g.border }

      -- Initialize local lsp modules
      require("plugins.lsp.diagnostics")
      require("plugins.lsp.handlers")

      -- Prevent high cpu usage due to new watch files implementation.
      -- NOTE: https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
      if vim.fn.has("nvim-0.10") == 0 then
        local ok, wf = pcall(require, "vim.lsp._watchfiles")
        if ok then
          -- disable lsp watcher. Too slow on linux
          wf._watchfunc = function()
            return function() end
          end
        end
      end
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
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
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
