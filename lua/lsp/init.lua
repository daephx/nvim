-- Neovim LSP Configuration (Language Server Protocol)
-- Setup native lsp using lspconfig helper plugin

-- Define default variables
local server_mpath = 'lsp/servers'
local default_options = {
  capabilities = require('lsp.capabilities'),
  on_attach = require('lsp.attach'),
}

-- Initialize local lsp modules
require('lsp.diagnostics')
require('lsp.handlers')
require('lsp.icons')
require('lsp.null-ls')
require('lsp.lspconfig')
require('lsp.mason')
require('mason-lspconfig').setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local config -- Set default empty config table
    local namespace = table.concat({ server_mpath, server_name }, '/')
    local module_ok, module = pcall(require, namespace)
    if module_ok and type(module) == 'table' then
      -- Set config to module return table if present
      config = type(module.setup) == 'function' and module.setup({}) or module
    end
    -- Extend default_options with module return table
    config = vim.tbl_deep_extend('force', default_options, config or {})
    -- Initialize server with evaluated or empty config table
    require('lspconfig')[server_name].setup(config)
  end,

  ['rust_analyzer'] = function()
    require('lsp/servers/rust_analyzer')
  end,

  ['jdtls'] = function()
    require('lsp/servers/jdtls')
  end,

  -- ['zk'] = function()
  --   require('plugins/zk')
  -- end,
})
