-- html-lsp: Language-server configuration
-- https://github.com/microsoft/vscode-html-languageservice

---@type vim.lsp.Config
return {
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 120,
        wrapAttributes = "auto",
      },
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
}
