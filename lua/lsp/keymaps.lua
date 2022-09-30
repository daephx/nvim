local M = {}

M.initialize_keymaps = function(_, bufnr)
  local defaults = { buffer = bufnr, remap = false, silent = true }
  local function map(mode, k, cb, opts)
    local options = vim.tbl_extend('force', defaults, opts)
    vim.keymap.set(mode, k, cb, options)
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {})
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {})
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
  map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})
  map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', {})
  map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', {})
  map(
    'n',
    '<leader>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    {}
  )
  map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {})
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
  map(
    'n',
    '<leader>ca',
    '<cmd>lua require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor())<CR>',
    {}
  )
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {})
  map('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', {})
  map('v', 'gf', "<cmd>'<,'>lua vim.lsp.buf.range_formatting()<CR>", {})
  map('n', '<leader>de', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
  map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', {})
  map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {})
end

return M
