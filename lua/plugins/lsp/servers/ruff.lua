-- ruff: Ruff Language-server configuration
-- https://github.com/astral-sh/ruff

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP: Disable hover capability from Ruff",
  group = vim.api.nvim_create_augroup("LspAttach#Ruff#DisableHover", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil and client["name"] == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
})

---@type config.lsp.ClientConfig
return {
  init_options = {
    settings = {
      lineLength = 88,
      quote_style = "double",
      indent_style = "space",
      docstring_code_format = true,
    },
  },
}
