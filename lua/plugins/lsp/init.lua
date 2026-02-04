-- Neovim LSP Configuration (Language Server Protocol)
-- Setup native lsp using lspconfig helper plugin

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
      { -- Supercharge your Rust experience in Neovim!
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
      },
    },
    config = function()
      -- Initialize local lsp modules
      require("plugins.lsp.diagnostics")

      -- Set default config for all servers
      vim.lsp.config("*", {
        capabilities = require("plugins.lsp.capabilities"),
        on_attach = require("plugins.lsp.attach"),
      })
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
    event = "InsertEnter",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = function()
      require("lsp_signature").on_attach({
        hint_enable = false,
        hint_prefix = "■ ",
      })
    end,
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
