-- lsp/icons.lua

local M = {}

M.diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = { ' ', 'DiagnosticSignError' },
  [vim.diagnostic.severity.WARN] = { ' ', 'DiagnosticSignWarn' },
  [vim.diagnostic.severity.INFO] = { ' ', 'DiagnosticSignInfo' },
  [vim.diagnostic.severity.HINT] = { ' ', 'DiagnosticSignHint' },
}

-- Apply diagnostic symbols in the sign column
for _, tbl in pairs(M.diagnostic_icons) do
  local opts = { text = tbl[1], texthl = tbl[2], linehl = 'none', numhl = 'none' }
  vim.fn.sign_define(tbl[2], opts)
end

M.completion_kinds = {
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

-- Apply completion kinds
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(M.completion_kinds) do
  kinds[i] = M.diagnostic_icons[kind] or kind
end

return M
