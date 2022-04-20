-- Native LSP Configurations (Language Server Protocol)

-- Prevent loading if coc is enabled
if vim.g.coc_enabled then
  return
end

local mappings = require('lsp.mappings')

local M = {}

-- Diagnostic Settings
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    focusable = false,
    header = { 'Diagnostics:', 'Normal' },
    prefix = '✗ ',
    show_header = true,
    source = 'always',
  },
  virtual_text = {
    prefix = '✗ ',
    source = 'always',
    spacing = 4,
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
})

-- Apply diagnostic symbols in the sign column
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.cmd('highlight! link ' .. hl .. ' Diagnostic' .. type)
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = 'none' })
end

-- Use an on_attach function to set LSP related actions for
-- when the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Enable LSP Mappings
  mappings.set_lsp_keymaps(bufnr)

  -- Show line diagnostics on cursor position in hover window
  vim.cmd(
    [[ autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"}) ]]
  )

  -- Apply Auto-formatting on save
  -- vim.cmd([[ autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100) ]])
  vim.cmd([[ autocmd BufWritePre * lua vim.lsp.buf.formatting_sync({}, 500) ]])

  -- Manual :Format command
  -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
  vim.cmd([[ command! -range Format '<,'>lua vim.lsp.buf.range_formatting() ]])
end

--- Capabilities ---

-- Define lsp default capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'additionalTextEdits',
    'detail',
    'documentation',
  },
}

--- Modules ---

require('lsp.null-ls')
require('lsp.installer')

return M
