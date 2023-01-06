local M = {}

-- Initialize and attach Language Server keymaps to the active buffer
---@param bufnr integer
M.initialize_keymaps = function(_, bufnr)
  local defaults = { buffer = bufnr, remap = false, silent = true }
  local function map(mode, k, cb, opts)
    local options = vim.tbl_extend("force", defaults, opts)
    vim.keymap.set(mode, k, cb, options)
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map("n", "gD", vim.lsp.buf.declaration, {
    desc = "Goto declaration",
  })
  map("n", "gd", vim.lsp.buf.definition, {
    desc = "Goto definition",
  })
  map("n", "K", vim.lsp.buf.hover, {
    desc = "Show hover diagnostic",
  })
  map("n", "gi", vim.lsp.buf.implementation, {
    desc = "Goto implementation",
  })
  map("n", "<C-k>", vim.lsp.buf.signature_help, {
    desc = "Signature Help",
  })
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {
    desc = "Add workspace folder",
  })
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {
    desc = "Remove workspace folder",
  })
  map("n", "<leader>wl", function()
    local folders = vim.lsp.buf.list_workspace_folders()
    print(vim.inspect(folders))
  end, { desc = "Show workspace folders" })
  map("n", "<leader>D", vim.lsp.buf.type_definition, {
    desc = "Show type definitions",
  })
  map("n", "<leader>rn", vim.lsp.buf.rename, {
    desc = "Rename reference",
  })
  map("n", "gr", vim.lsp.buf.references, {
    desc = "Goto references",
  })
  map({ "n", "v" }, "gf", function()
    local formatting = require("plugins.lsp.handlers.formatting")
    formatting.format_document()
  end, {
    desc = "Format document",
  })
  map("n", "<leader>de", vim.diagnostic.open_float, {
    desc = "Open diagnostic float",
  })
  map("n", "[d", vim.diagnostic.goto_prev, {
    desc = "Previous diagnostic",
  })
  map("n", "]d", vim.diagnostic.goto_next, {
    desc = "Next diagnostic",
  })
  map("n", "<leader>dq", vim.diagnostic.setloclist, {
    desc = "Diagnostic loclist",
  })
end

return M
