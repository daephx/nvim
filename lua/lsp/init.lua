-- Native LSP Configurations (Language Server Protocol)
if not pcall(require, 'lspconfig') then
  local msg = table.concat({
    'nvim-lsp failed to initialize',
    'Unable to locate dependency "lspconfig"',
  }, '\n')
  vim.notify(msg, vim.lsp.log_levels.ERROR, { title = 'Plugin Error' })
  return
end

local lsp_utils = require('lsp.utils')

local diagnostic_icons = require('lsp.icons').diagnostic_icons

-- Apply diagnostic symbols in the sign column
for _, tbl in pairs(diagnostic_icons) do
  local opts = { text = tbl[1], texthl = tbl[2], linehl = 'none', numhl = 'none' }
  vim.fn.sign_define(tbl[2], opts)
end

-- Diagnostic Settings
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    focusable = false,
    header = { ' Diagnostics:', 'Normal' },
    show_header = true,
    source = 'always',
    prefix = function(diagnostic)
      local res = diagnostic_icons[diagnostic.severity]
      return string.format(' %s', res[1]), res[2]
    end,
  },
  virtual_text = {
    prefix = '✗',
    spacing = 4,
    severity = vim.diagnostic.severity.WARN,
    source = 'if_many',
  },
})

--- Attach ---

-- Use an on_attach function to set LSP related actions for
-- when the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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

vim.lsp.handlers['textDocument/definition'] = lsp_utils.goto_definition('vsplit')

-- Override diagnostic hover window
lsp_utils.override_diagnostic_float()

--- Modules ---

require('lsp.null-ls')
require('lsp.installer').setup({
  capabilities = lsp_utils.initialize_capabilities(),
  language_servers = language_servers,
  on_attach = on_attach,
})
