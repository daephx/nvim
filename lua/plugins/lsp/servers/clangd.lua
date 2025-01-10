-- clangd: Language-server configuration
-- https://github.com/clangd/clangd

---@type config.lsp.ClientConfig
return {
  cmd = {
    "clangd",
    "--all-scopes-completion",
    "--background-index",
    "--clang-tidy",
    "--clang-tidy-checks=*",
    "--completion-style=detailed",
    "--cross-file-rename",
    "--enable-config",
    "--fallback-style=microsoft",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--offset-encoding=utf-16",
  },
  init_options = {
    clangdFileStatus = true,
    completeUnimported = true,
    semanticHighlighting = true,
    usePlaceholders = true,
  },
}
