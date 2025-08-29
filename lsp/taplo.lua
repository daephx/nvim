-- taplo: A TOML toolkit written in Rust
-- https://github.com/tamasfe/taplo

---@type vim.lsp.Config
return {
  settings = {
    evenBetterToml = {
      cachePath = vim.fn.stdpath("cache") .. "/taplo",
      schema = {
        enabled = true,
        repositoryEnabled = true,
        repositoryUrl = "https://taplo.tamasfe.dev/schema_index.json",
      },
      formatter = {
        alignComments = false,
        alignEntries = false,
        allowedBlankLines = 1,
        indentEntries = false,
        indentTables = false,
        reorderKeys = false,
      },
    },
  },
}
