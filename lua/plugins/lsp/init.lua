-- Neovim LSP Configuration (Language Server Protocol)
-- Setup native lsp using lspconfig helper plugin

-- Define default variables
local server_mpath = "plugins/lsp/settings"
local default_options = {
  capabilities = require("plugins.lsp.capabilities"),
  on_attach = require("plugins.lsp.attach"),
}

-- Initialize local lsp modules
require("plugins.lsp.diagnostics")
require("plugins.lsp.handlers")
require("plugins.lsp.icons")
require("plugins.lsp.null-ls")
require("plugins.lsp.lspconfig")
require("plugins.lsp.mason")
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
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
