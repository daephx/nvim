local M = {}

M.autoformat = true

local notify = function(msg)
  local level = vim.log.levels.INFO
  vim.notify(msg, level, { title = "Format" })
end

-- Toggle document formatting on save
M.toggle = function()
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
M.format = function()
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
---@param client table
---@param bufnr integer
M.enable_auto_formatting = function(client, bufnr)
  -- Prevent formatting if client disabled it
  local disabled = (
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  )
  -- Apply autocmd if client supports formatting
  if not disabled or client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      desc = "Apply Auto-formatting for to document on save",
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
      callback = function()
        M.format()
      end,
    })

    -- Add formatting user command
    vim.api.nvim_create_user_command("Format", function()
      M.format()
    end, {})

    -- Add toggle formatting user command
    vim.api.nvim_create_user_command("FormatToggle", function()
      M.toggle()
    end, {})
  end
end

return M
