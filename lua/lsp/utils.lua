-- lsp.utils

local M = {}

local lspconfig = require('lspconfig')

M.rename_diagnostic_source = function(diagnostic)
  local replacements = { { 'Lua Diagnostics.', 'Sumneko' } }
  for _, item in pairs(replacements) do
    if diagnostic.source == item[1] then
      return item[2]
    end
  end

  return diagnostic.source
end

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

-- Define lsp default capabilities
M.initialize_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'additionalTextEdits',
      'detail',
      'documentation',
    },
  }
  return capabilities
end

local get_installed_servers = function(config_path)
  local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
  if not lsp_installer_ok then
    return
  end

  local server_list = vim.tbl_map(function(client)
    return client.name
  end, lsp_installer.get_installed_servers())

  local null_ok, _ = pcall(require, 'null-ls')
  if null_ok then
    table.insert(server_list, 'null-ls')
  end

  return server_list
end

M.initialize_servers = function(opts)
  local server_list = get_installed_servers(opts.config_path)

  for _, server in pairs(server_list) do
    local namespace = table.concat({ opts.config_path:match('/(.*)$'), server }, '/')
    local _, module = pcall(require, namespace)
    local config = {}
    if type(module) == 'table' then
      if type(module.setup) == 'function' then
        config = module.setup(opts.capabilities, opts.on_attach)
      end
    end

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
