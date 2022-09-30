local M = {}

M.initialize_keymaps = function(_, bufnr)
  local defaults = { buffer = bufnr, remap = false, silent = true }
  local function map(mode, k, cb, opts)
    local options = vim.tbl_extend('force', defaults, opts)
    vim.keymap.set(mode, k, cb, options)
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gD', vim.lsp.buf.declaration, {})
  map('n', 'gd', vim.lsp.buf.definition, {})
  map('n', 'K', vim.lsp.buf.hover, {})
  map('n', 'gi', vim.lsp.buf.implementation, {})
  map('n', '<C-k>', vim.lsp.buf.signature_help, {})
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {})
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {})
  map('n', '<leader>wl', function()
    local folders = vim.lsp.buf.list_workspace_folders()
    print(vim.inspect(folders))
  end, {})
  map('n', '<leader>D', vim.lsp.buf.type_definition, {})
  map('n', '<leader>rn', vim.lsp.buf.rename, {})
  map('n', 'gr', vim.lsp.buf.references, {})
  map('n', 'gf', vim.lsp.buf.formatting, {})
  map('v', 'gf', "<cmd>'<,'>lua vim.lsp.buf.range_formatting()<CR>", {})
  map('n', '<leader>de', vim.diagnostic.open_float, {})
  map('n', '[d', vim.diagnostic.goto_prev, {})
  map('n', ']d', vim.diagnostic.goto_next, {})
  map('n', '<leader>q', vim.diagnostic.setloclist, {})
  map('n', '<leader>f', vim.lsp.buf.formatting, {})
end

return M
