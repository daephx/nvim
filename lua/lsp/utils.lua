-- lsp.utils

local M = {}

local lspconfig = require('lspconfig')

local get_installed_servers = function()
  local lsp_installer = require('nvim-lsp-installer')
  -- Get configured servers from lsp-installer
  local server_list = vim.tbl_map(function(client)
    return client.name
  end, lsp_installer.get_installed_servers())

  -- insert null-ls if available
  if pcall(require, 'null-ls') then
    table.insert(server_list, 'null-ls')
  end

  return server_list
end

M.initialize_servers = function(opts)
  local server_list = get_installed_servers()

  -- Loop server list for local config
  for _, server in pairs(server_list) do
    local namespace = table.concat({ opts.config_path, server }, '/')
    local _, module = pcall(require, namespace)

    local config = {}
    if type(module) == 'table' then
      if type(module.setup) == 'function' then
        config = module.setup(opts.capabilities, opts.on_attach)
      end
    end

    -- Set lspconfig from module files
    -- Exclude null-ls as it shouldn't be enabled via lspconfig
    if server ~= 'null-ls' then
      lspconfig[server].setup(config)
    end
  end
end

M.override_diagnostic_float = function()
  -- Override global float preview function
  local _open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    opts.focusable = opts.focusable or false
    return _open_floating_preview(contents, syntax, opts, ...)
  end

  -- Override lspconfig ui options
  local windows = require('lspconfig.ui.windows')
  local _default_opts = windows.default_opts
  windows.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = 'rounded'
    return opts
  end
end

M.override_installer_float = function()
  vim.api.nvim_create_autocmd('FileType', {
    desc = 'Set floating buffer options for "lsp-installer"',
    group = vim.api.nvim_create_augroup('LspInstallerUI', {}),
    pattern = 'lsp-installer',
    callback = function()
      vim.api.nvim_win_set_config(0, { border = 'rounded' })
    end,
  })
end

return M
