-- Set icons for diagnostics and various plugins

local M = {}

M.dap = {
  Breakpoint = "",
  BreakpointCondition = { "", "DiagnosticWarn" },
  BreakpointRejected = { "", "DiagnosticError" },
  LogPoint = "󰆈",
  Stopped = { "󰁕", "DiagnosticWarn", "DapStoppedLine" },
}

M.diagnostics = {
  [vim.diagnostic.severity.ERROR] = { text = "", hl = "DiagnosticSignError" },
  [vim.diagnostic.severity.WARN] = { text = "", hl = "DiagnosticSignWarn" },
  [vim.diagnostic.severity.INFO] = { text = "", hl = "DiagnosticSignInfo" },
  [vim.diagnostic.severity.HINT] = { text = "󰌵", hl = "DiagnosticSignHint" },
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
  Array = "󰅪",
  Boolean = "◩",
  Class = "󰠱",
  Color = "󰏘",
  Constant = "󰏿",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "󰈙",
  Folder = "󰉋",
  Function = "󰊕",
  Interface = "",
  Key = "󰌋",
  Keyword = "󰌋",
  Method = "󰆧",
  Module = "",
  Namespace = "󰌗",
  Null = "󰟢",
  Number = "󰎠",
  Object = "󰅩",
  Operator = "󰆕",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "󰌗",
  Text = "󰉿",
  TypeParameter = "󰊄",
  Unit = "",
  Value = "󰎠",
  Variable = "󰆧",
}

-- Apply completion kinds
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(M.kinds) do
  kinds[i] = M.kinds[kind] or kind
end

return M
