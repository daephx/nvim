-- lsp.utils

local M = {}

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

-- Go-to definition in a split window
M.goto_definition = function(split_cmd)
  local util = vim.lsp.util
  local log = require('vim.lsp.log')

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5,
  -- call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        vim.api.nvim_command('copen')
        vim.api.nvim_command('wincmd p')
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

return M
