-- Lsp-Installer

local capabilities = require('lsp').capabilities
local on_attach = require('lsp').on_attach

local lsp_installer = require('nvim-lsp-installer')

-- Apply settings
lsp_installer.settings({
  -- The directory in which to install all servers.
  -- install_root_dir = path.concat { fn.stdpath("data"), "lsp_servers" },
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})

-- Auto-install LSP servers
-- Include the servers you want to have installed by default below
local default_servers = {
  'bashls',
  'jsonls',
  'pyright',
  'sumneko_lua',
  'vimls',
  'yamlls',
}

-- Install from list of default_servers
for _, name in pairs(default_servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      server:install()
    end
  end
end

-- Server activation callback
lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  local ok, mod = pcall(require, 'lsp.servers' .. server.name)
  if ok then
    opts = vim.tbl_extend('force', opts, mod.setup)
  end
  server:setup(opts)
  vim.cmd('do User LspAttachBuffers')
end)
