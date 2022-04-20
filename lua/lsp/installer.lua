-- Lsp-Installer

local M = {}

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

M.setup = function(opts)
  -- Server activation callback
  lsp_installer.on_server_ready(function(server)
    opts = { capabilities = opts.capabilities, on_attach = opts.on_attach }
    local ok, mod = pcall(require, 'lsp.servers.' .. server.name)
    if ok then
      opts = vim.tbl_extend('force', opts, mod.setup)
    end
    server:setup(opts)
    vim.cmd('do User LspAttachBuffers')
  end)

  -- Install from list of default_servers
  for name, config in pairs(opts.language_servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and config.auto_install then
      if not server:is_installed() then
        server:install()
      end
    end
  end
end

return M
