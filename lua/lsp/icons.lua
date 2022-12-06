-- lsp/icons.lua

local M = {}

M.diagnostics = {
  [vim.diagnostic.severity.ERROR] = { sign = '', hl = 'DiagnosticSignError' },
  [vim.diagnostic.severity.WARN] = { sign = '', hl = 'DiagnosticSignWarn' },
  [vim.diagnostic.severity.INFO] = { sign = '', hl = 'DiagnosticSignInfo' },
  [vim.diagnostic.severity.HINT] = { sign = '', hl = 'DiagnosticSignHint' },
}

-- Apply diagnostic symbols in the sign column
for _, tbl in pairs(M.diagnostics) do
  vim.fn.sign_define(tbl.hl, {
    sign = tbl.sign,
    signhl = tbl.hl,
    numhl = 'none',
  })
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
