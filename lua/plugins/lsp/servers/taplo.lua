-- taplo: A TOML toolkit written in Rust
-- https://github.com/tamasfe/taplo

---@type config.lsp.ClientConfig
return {
  settings = {
    evenBetterToml = {
      schema = {
        enabled = true,
        repositoryEnabled = true,
        repositoryUrl = "https://taplo.tamasfe.dev/schema_index.json",
      },
      cachePath = vim.fn.stdpath("cache") .. "/taplo",
      formatter = {
        alignEntries = false,
        allowedBlankLines = 1,
        indentEntries = false,
        indentTables = false,
        reorderKeys = false,
      },
    },
  },
}
