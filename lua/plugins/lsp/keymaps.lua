local format = require("plugins.lsp.handlers.format")
local util = require("config.util")

local M = {}

---Initialize and attach Language Server keymaps to the active buffer
---@param _ vim.lsp.Client
---@param bufnr integer
M.initialize_keymaps = function(_, bufnr)
  -- stylua: ignore
  util.register_keymaps({
    buffer = bufnr,
    remap = false,
    silent = true,
  }, {
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    { "n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" } },
    { "n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" } },
    { "n", "gy", vim.lsp.buf.type_definition, { desc = "Show type definitions" } },

    { { "n", "v" }, "grF", format.toggle, { remap = true, desc = "Toggle format" } },
    { { "n", "v" }, "grf", format.execute, { remap = true, desc = "Format document" } },
  })
end

return M
