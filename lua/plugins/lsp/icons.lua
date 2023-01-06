-- lsp/icons.lua

local M = {}

M.diagnostics = {
  [vim.diagnostic.severity.ERROR] = { text = "", hl = "DiagnosticSignError" },
  [vim.diagnostic.severity.WARN] = { text = "", hl = "DiagnosticSignWarn" },
  [vim.diagnostic.severity.INFO] = { text = "", hl = "DiagnosticSignInfo" },
  [vim.diagnostic.severity.HINT] = { text = "", hl = "DiagnosticSignHint" },
}

-- Apply diagnostic symbols in the sign column
for _, tbl in pairs(M.diagnostics) do
  vim.fn.sign_define(tbl.hl, {
    text = tbl.text,
    texthl = tbl.hl,
    numhl = "none",
  })
end

M.kinds = {
  Class = "ﴯ",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "m",
  Module = "",
  Operator = "",
  Property = "",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

-- Apply completion kinds
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(M.kinds) do
  kinds[i] = M.kinds[kind] or kind
end

return M
