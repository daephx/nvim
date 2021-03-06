-- Native LSP Configurations (Language Server Protocol)

-- Prevent loading if coc is enabled
if vim.g.coc_enabled then
  return
end

local api = vim.api
local lsp = vim.lsp

-- Diagnostic Settings
vim.diagnostic.config({

  signs = true,
  underline = true,
  update_in_insert = false,

  float = {
    source = 'always',
    show_header = true,
    -- prefix = "✗",
    -- border = 'rounded',
    focusable = false,
  },
  virtual_text = false,
  -- {
  --   source = "always",
  --   prefix = "✗", -- Could be '●', '▎', '✗'
  -- },
})

-- Apply diagnostic symbols in the sign column
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.cmd('highlight! link ' .. hl .. ' Diagnostic' .. type)
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = 'none' })
end

-- Close LspInfo window using 'q'
vim.cmd([[ autocmd! FileType lspinfo nnoremap <silent> <buffer> qq :q<CR> ]])

-- Reference dependency modules
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'additionalTextEdits',
    'detail',
    'documentation',
  },
}

-- Overriding the default LSP server options

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap(
    'n',
    '<leader>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts
  )
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap(
    'n',
    '<leader>ca',
    '<cmd>lua require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor())<CR>',
    opts
  )
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('v', 'gf', "<cmd>'<,'>lua vim.lsp.buf.range_formatting()<CR>", opts)
  buf_set_keymap('n', '<leader>de', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

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

--- Null-LS ---

-- Safely load module
local ok, null_ls = pcall(require, 'lsp.null-ls')
if ok then
  null_ls.setup()
end

--- Lsp-Installer ---

-- Initialize module
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

-- Auto-install LSP servers
-- Include the servers you want to have installed by default below
local default_servers = {
  'bashls',
  'jsonls',
  'pyright',
  'sumneko_lua',
  'vimls',
  'yamlls',
}
-- Loop default list
for _, name in pairs(default_servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      server:install()
    end
  end
end

-- Server activation callback
lsp_installer.on_server_ready(function(server)
  local options = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  local ok, mod = pcall(require, 'lsp.' .. server.name)
  if ok then
    options = vim.tbl_extend('force', options, mod.setup)
  end
  server:setup(options)
  vim.cmd('do User LspAttachBuffers')
end)
