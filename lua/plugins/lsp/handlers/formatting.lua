local M = {}

local disabled_formatters = {
  global = { "copilot" },
  filetypes = {},
}

-- Determine if buffer has configured null-ls formatting generators for filetype
---@param bufnr integer
---@return boolean
local function null_has_formatter(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local generators = require("null-ls.generators").get_available(
    filetype,
    require("null-ls.methods").internal.FORMATTING
  )
  return #generators > 0
end

-- Get list of language servers attached to the current buffer
---@param bufnr integer
---@return table
local function buf_get_clients(bufnr)
  local list = {}
  for _, client in pairs(vim.lsp.buf_get_clients(bufnr)) do
    table.insert(list, client.name)
  end
  return list
end

-- Activate document formatting filter to select a preferred formatter
---@param bufnr integer?
M.format_document = function(bufnr)
  bufnr = bufnr or 0
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

      -- Filter user disable clients
      local disabled_g = disabled_formatters.global or {}
      if vim.tbl_contains(disabled_g, client.name) then
        return false
      end

      -- Match disabled clients by filetype
      local disabled_ft = disabled_formatters.filetypes[filetype] or {}
      if vim.tbl_contains(disabled_ft, client.name) then
        return false
      end

      -- Prefer null-ls or EFM if present in client list
      if vim.tbl_contains(buf_get_clients(bufnr), "null-ls") then
        if client.name ~= "null-ls" and null_has_formatter(bufnr) then
          return false
        end
      end

      return true
    end,
  })
end

-- Enable document formatting autocmd to trigger on BufWritePre
---@param client table
---@param bufnr integer
M.enable_auto_formatting = function(client, bufnr)
  local group = vim.api.nvim_create_augroup("LspFormatting", {})
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_user_command("Format", "do User LspFormatting", {})
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Apply Auto-formatting for to document on save",
      group = group,
      pattern = "*",
      callback = function(opts)
        M.format_document(opts.bufnr)
      end,
    })
  end
end

return M
