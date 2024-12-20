local format = require("plugins.lsp.handlers.format")

local M = {}

-- Initialize and attach Language Server keymaps to the active buffer
---@param _ vim.lsp.Client
---@param bufnr integer
M.initialize_keymaps = function(_, bufnr)
  local util = require("config.util")
  local opts = { buffer = bufnr, remap = false, silent = true }

  -- stylua: ignore
  util.register_keymaps(opts, {
    { "n", "<leader>cl", "<cmd>LspInfo<cr>", desc = "Open LspInfo" },

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    { "n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" } },
    { "n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" } },
    { "n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" } },
    { "n", "gr", vim.lsp.buf.references, { desc = "Goto references" } },
    { "n", "gy", vim.lsp.buf.type_definition, { desc = "Show type definitions" } },

    { "i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" } },
    { "n", "K", vim.lsp.buf.hover, { desc = "Show hover diagnostic" } },
    { "n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" } },

    { "n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" } },
    { "n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" } },

    { { "n", "v" }, "<leader>cF", format.format_toggle, { remap = true, desc = "Toggle format" } },
    { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" } },
    { { "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" } },
    { { "n", "v" }, "<leader>cf", format.format_document, { remap = true, desc = "Format document" } },
  })

  -- TODO: Compatibility for Neovim 0.11+; remove when stable packages are updated.
  if vim.fn.has("nvim-0.11") == 1 then
    -- stylua: ignore
    util.register_keymaps(opts, {
      { "n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" } },
      { "n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" } },

      ---@diagnostic disable-next-line: redundant-parameter
      { "n", "<C-k>", function() vim.lsp.buf.signature_help({ border = vim.g.border }) end, { desc = "Signature Help" } },

      ---@diagnostic disable-next-line: redundant-parameter
      { "n", "K", function() vim.lsp.buf.hover({ border = vim.g.border }) end, { desc = "Show hover diagnostic" } },
    })
  end
end

return M
