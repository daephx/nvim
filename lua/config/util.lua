local M = {}

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
