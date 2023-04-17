-- rust_analyzer: Rust language server
local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
if not rust_tools_ok then
  return
end

local capabilities = require("plugins.lsp.capabilities")
local on_attach = require("plugins.lsp.attach")

rust_tools.setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})
