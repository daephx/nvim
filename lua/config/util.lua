-- Neovim utility functions to be used across config files.

local M = {}

---Wrapper to extend options for various keymap definitions
---@param options table|nil default options for keymaps, assign `nil` to use defaults.
---@param keymaps table list of keymap definitions to be applied
function M.register_keymaps(options, keymaps)
  for _, map in pairs(keymaps) do
    local mode, lhs, rhs, opts = unpack(map)
    opts = vim.tbl_extend("force", options or {}, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
