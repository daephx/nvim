-- Native LSP Configurations (Language Server Protocol)

-- Prevent loading if coc is enabled
if vim.g.coc_enabled then
  return
end

-- Enable/Disable Null-LS
vim.g.null_ls_disable = false

-- Define settings for lsp servers
local language_servers = {
  ['bashls'] = { auto_install = true, disable_formatting = false },
  ['clangd'] = { auto_install = false, disable_formatting = false },
  ['html'] = { auto_install = true, disable_formatting = true },
  ['jsonls'] = { auto_install = true, disable_formatting = true },
  ['pyright'] = { auto_install = true, disable_formatting = true },
  ['sumneko_lua'] = { auto_install = true, disable_formatting = true },
  ['tsserver'] = { auto_install = false, disable_formatting = true },
  ['vimls'] = { auto_install = true, disable_formatting = false },
  ['yamlls'] = { auto_install = true, disable_formatting = true },
}

local mappings = require('lsp.mappings')

local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = { ' ', 'DiagnosticSignError' },
  [vim.diagnostic.severity.WARN] = { ' ', 'DiagnosticSignWarn' },
  [vim.diagnostic.severity.INFO] = { ' ', 'DiagnosticSignInfo' },
  [vim.diagnostic.severity.HINT] = { ' ', 'DiagnosticSignHint' },
}

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
    header = { 'Diagnostics:', 'Normal' },
    prefix = '✗ ',
    show_header = true,
    source = 'always',
  },
  virtual_text = {
    prefix = '✗',
    spacing = 4,
    severity = vim.diagnostic.severity.ERROR,
    source = 'if_many',
  },
})

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

--- Handlers ---

local lsp_utils = require('lsp.utils')
vim.lsp.handlers['textDocument/definition'] = lsp_utils.goto_definition('vsplit')

--- Capabilities ---

-- Define lsp default capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
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

--- Modules ---

require('lsp.null-ls')
require('lsp.installer').setup({
  capabilities = capabilities,
  language_servers = language_servers,
  on_attach = on_attach,
})
