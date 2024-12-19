-- Neovim utility functions to be used across config files.

local M = {}

---@class config.KeymapSpec
---@field [1] string|string[] mode
---@field [2] string lhs
---@field [3] string|function rhs
---@field opts? vim.keymap.set.Opts

---Wrapper to extend options for various keymap definitions
---@param options table|nil default options for keymaps, assign `nil` to use defaults.
---@param keymaps config.KeymapSpec[] list of keymap definitions to be applied
function M.register_keymaps(options, keymaps)
  for _, map in pairs(keymaps) do
    local mode, lhs, rhs, opts = unpack(map)
    opts = vim.tbl_extend("force", options or {}, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
