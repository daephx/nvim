-- lsp.utils

local M = {}

local lspconfig = require('lspconfig')

-- Enable diagnostic hover window at cursor position on CursorHold
M.enable_hover_diagnostics = function(bufnr)
  vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    buffer = bufnr,
    desc = 'Show line diagnostics on cursor position in hover window',
    group = vim.api.nvim_create_augroup('LspHoverDiagnostics', {}),
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

-- Display signature help
-- TODO: Causes error prompts in &diff, gitcommit and other unsupported filetypes
M.enable_signature_help = function(client, bufnr)
  if client.supports_method('textDocument/signatureHelp') then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      desc = 'Show signature help on cursor position in hover window',
      callback = function()
        vim.lsp.buf.signature_help(nil, { scope = 'cursor' })
      end,
    })
  end
end

M.enable_code_lens = function(client, bufnr)
  if client.supports_method('textDocument/codeLens') then
    local augroup = vim.api.nvim_create_augroup('LspCodeLens', {})
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'BufWritePost', 'CursorHold' }, {
      buffer = bufnr,
      desc = '',
      group = augroup,
      callback = vim.lsp.codelens.refresh,
    })
    vim.schedule(vim.lsp.codelens.refresh)
  end
end

-- Highlight references under cursor
M.enable_document_highlighting = function(client, bufnr)
  if client.supports_method('textDocument/documentHighlight') then
    local augroup = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })
    vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
      desc = 'Link LSP document reference highlighting to IncSearch',
      group = augroup,
      callback = function()
        local opts = { link = 'IncSearch', bold = true }
        vim.api.nvim_set_hl(0, 'LspReferenceRead', opts)
        vim.api.nvim_set_hl(0, 'LspReferenceText', opts)
        vim.api.nvim_set_hl(0, 'LspReferenceWrite', opts)
      end,
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      desc = 'Apply LSP documment reference highlighting on CursorHold',
      group = augroup,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'CursorMovedI' }, {
      buffer = bufnr,
      desc = 'Disable LSP documment reference highlighting on CursorMoved',
      group = augroup,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

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

return M
