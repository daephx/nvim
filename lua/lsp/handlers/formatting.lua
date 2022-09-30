local M = {}

local disabled_formatters = {
  global = { 'copilot' },
  filetypes = {},
}

-- Determine if null-ls sources has configured formatter for filetype
---@param ft string
---@return boolean
local function null_has_formatter(ft)
  local sources = require('null-ls.sources')
  local filter = vim.tbl_map(function(source)
    -- Map active sources with formatting method
    if source.methods['NULL_LS_FORMATTING'] then
      return true
    end
  end, sources.get_available(ft))
  -- If filter table is empty
  if rawequal(next(filter), nil) then
    return false
  end

  return true
end

-- Activate document formatting filter to select a preferred formatter
---@param bufnr integer
M.format_document = function(bufnr)
  bufnr = bufnr or 0
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')

      -- Filter user disable clients
      local disabled_g = disabled_formatters.global or {}
      if vim.tbl_contains(disabled_g, client.name) then
        print('user global: false')
        return false
      end

      -- Match disabled clients by filetype
      local disabled_ft = disabled_formatters.filetypes[ft] or {}
      if vim.tbl_contains(disabled_ft, client.name) then
        print('user filetype: false')
        return false
      end

      -- Get list of buffer client names
      local buf_clients = vim.tbl_map(function(c)
        return c.name
      end, vim.lsp.buf_get_clients(bufnr))

      -- Prefer null-ls or EFM if present in client list
      if vim.tbl_contains(buf_clients, 'null-ls') then
        if client.name ~= 'null-ls' and null_has_formatter(ft) then
          return false
        end
      end

      -- Finally, send true for unfiltered client
      local msg = table.concat({ '[LSP] Format Document:', client.name }, ' ')
      vim.notify(msg, vim.lsp.log_levels.info, { title = 'LSP Formatting' })
      return true
    end,
  })
end

-- Enable document formatting autocmd to trigger on BufWritePre
---@param client table
---@param bufnr integer
M.enable_auto_formatting = function(client, bufnr)
  local group = vim.api.nvim_create_augroup('LspFormatting', {})
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_user_command('Format', 'do User LspFormatting', {})
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      desc = 'Apply Auto-formatting for to document on save',
      group = group,
      callback = function(opts)
        M.format_document(opts.bufnr)
      end,
    })
  end
end

return M
