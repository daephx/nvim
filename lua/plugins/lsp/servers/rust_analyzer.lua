-- rust_analyzer: Rust language server
-- https://github.com/rust-lang/rust-analyzer
local capabilities = require("plugins.lsp.capabilities")
local on_attach = require("plugins.lsp.attach")

vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
  },
  dap = {},
}
