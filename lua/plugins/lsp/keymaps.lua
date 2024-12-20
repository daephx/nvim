local format = require("plugins.lsp.handlers.format")

local M = {}

-- Display buffer workspace folders
local list_workspace_folders = function()
  vim.print(vim.lsp.buf.list_workspace_folders())
end

-- Initialize and attach Language Server keymaps to the active buffer
---@param _ vim.lsp.Client
---@param bufnr integer
M.initialize_keymaps = function(_, bufnr)
  local util = require("config.util")
  local opts = { buffer = bufnr, remap = false, silent = true }
  util.register_keymaps(opts, {
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    { "n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" } },
    { "n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Show type definitions" } },
    { "n", "<leader>de", vim.diagnostic.open_float, { desc = "Open diagnostic float" } },
    { "n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" } },
    { "n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename reference" } },
    { "n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" } },
    { "n", "<leader>wl", list_workspace_folders, { desc = "Show workspace folders" } },
    { "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" } },
    { "n", "K", vim.lsp.buf.hover, { desc = "Show hover diagnostic" } },
    { "n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" } },
    { "n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" } },
    { "n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" } },
    { "n", "ga", vim.lsp.buf.code_action, { desc = "Code actions" } },
    { "n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" } },
    { "n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" } },
    { "n", "gr", vim.lsp.buf.references, { desc = "Goto references" } },

    { { "n", "v" }, "gf", format.format_document, { remap = true, desc = "Format document" } },
  })
end

return M
