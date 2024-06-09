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
  Error = "",
  Warn = "",
  Info = "",
  Hint = "󰌵",
}

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

return M
