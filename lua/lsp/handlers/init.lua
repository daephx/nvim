local mappings = require('lsp.mappings')

-- Use an on_attach function to set LSP related actions for
-- when the language server attaches to the current buffer
local default_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Enable LSP Mappings
  mappings.set_lsp_keymaps(bufnr)

  -- Prevent built in formatting for specific language servers
  -- effective when using external formatters with null-ls
  for server, opts in pairs(language_servers) do
    if client.name == server and opts.disable_formatting then
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end
  end

  -- Show line diagnostics on cursor position in hover window
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    desc = 'Show line diagnostics on cursor position in hover window',
    buffer = 0,
    callback = function()
      vim.diagnostic.open_float(nil, { scope = 'cursor' })
    end,
  })

  if client.server_capabilities.document_formatting then
    vim.api.nvim_create_user_command('Format', function()
      vim.lsp.buf.range_formatting()
    end, {})
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      desc = 'Apply Auto-formatting for to document on save',
      buffer = 0,
      callback = vim.lsp.buf.formatting_sync,
    })
  end
end

--- Handlers ---

-- Define LSP Handlers
local initialize_handlers = function()
  -- vim.lsp.handlers['textDocument/definition'] = lsp_utils.goto_definition('vsplit')
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )
end

return {
  default_attach = default_attach,
  initialize_handlers = initialize_handlers,
}
