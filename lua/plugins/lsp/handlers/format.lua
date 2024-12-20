local M = {}

M.autoformat = true

local notify = function(msg)
  local level = vim.log.levels.INFO
  vim.notify(msg, level, { title = "Format" })
end

-- Toggle document formatting on save
M.format_toggle = function()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil ---@type boolean|nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end
  if M.autoformat then
    notify("[LSP]: Formatting on save 'Enabled'")
  else
    notify("[LSP]: Formatting on save 'Disabled'")
  end
end

-- Activate document formatting filter to select a preferred formatter
M.format_document = function()
  local bufnr = vim.api.nvim_get_current_buf() ---@type integer
  if vim.b.autoformat == false then
    return
  end
  local ft = vim.bo[bufnr].filetype ---@type string
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  })
end

-- Enable document formatting autocmd to trigger on BufWritePre
---@param client vim.lsp.Client
---@param bufnr integer
M.enable_auto_format = function(client, bufnr)
  if
    client.server_capabilities.documentFormattingProvider
    or client.supports_method("textDocument/formatting")
  then
    -- Add formatting user commands
    vim.api.nvim_create_user_command("Format", M.format_document, {})
    vim.api.nvim_create_user_command("FormatToggle", M.format_toggle, {})

    -- Add autocmd to handle format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      desc = "Apply Auto-formatting for to document on save",
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
      callback = M.format_document,
    })
  end
end

return M
