local M = {}

M.diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = { ' ', 'DiagnosticSignError' },
  [vim.diagnostic.severity.WARN] = { ' ', 'DiagnosticSignWarn' },
  [vim.diagnostic.severity.INFO] = { ' ', 'DiagnosticSignInfo' },
  [vim.diagnostic.severity.HINT] = { ' ', 'DiagnosticSignHint' },
}

M.completeion_icons = {
  Class = 'ﴯ',
  Color = '',
  Constant = '',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = '',
  File = '',
  Folder = '',
  Function = '',
  Interface = '',
  Keyword = '',
  Method = 'm',
  Module = '',
  Operator = '',
  Property = '',
  Reference = '',
  Snippet = '',
  Struct = '',
  Text = '',
  TypeParameter = '',
  Unit = '',
  Value = '',
  Variable = '',
}

M.initialize_icons = function()
  -- Apply diagnostic symbols in the sign column
  for _, tbl in pairs(M.diagnostic_icons) do
    local opts = { text = tbl[1], texthl = tbl[2], linehl = 'none', numhl = 'none' }
    vim.fn.sign_define(tbl[2], opts)
  end
end

return M
