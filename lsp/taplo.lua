-- taplo: A TOML toolkit written in Rust
-- https://github.com/tamasfe/taplo
local nvim_cache = vim.fn.stdpath("cache")
local taplo_cache = vim.fs.joinpath(nvim_cache, "taplo")

-- Set up taplo
---@type vim.lsp.Config
return {
  settings = {
    evenBetterToml = {
      cachePath = taplo_cache,
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
