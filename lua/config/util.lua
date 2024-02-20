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

---Define how folded lines should be displayed
---@return string
function M.foldtext()
  local foldstart = vim.fn.getline(vim.v.foldstart)
  local foldend = vim.fn.getline(vim.v.foldend)
  local linecount = vim.v.foldend - vim.v.foldstart + 1
  local tabwidth = string.rep(" ", vim.bo.tabstop)
  return string.format(
    "%s … %s %s",
    ---@cast foldstart string
    vim.fn.substitute(foldstart, "\t", tabwidth, "g"),
    ---@cast foldend string
    vim.fn.trim(foldend),
    string.format("[%s lines]", linecount)
  )
end

return M
