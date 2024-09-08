-- Utility functions for loading and managing neovim colorschemes.
-- Provides color handling, highlight setup, and event-based updates.

local M = {}

---Check if colorscheme filename is available in the runtimepath.
---@param colors_name string
---@return boolean
M.is_available = function(colors_name)
  for _, theme in pairs(vim.api.nvim_get_runtime_file("colors/*.*", true)) do
    local theme_file = string.match(theme, "/colors/(%w+)%.[lua|vim]")
    if theme_file == colors_name then
      return true
    end
  end
  return false
end

---Get color table from highlight group.
---@param name string higroup name.
---@return table
M.get_hl = function(name)
  local labels = { "bg", "fg", "sp" }
  local colors = vim.api.nvim_get_hl(0, { name = name })
  local res = {}
  for k, v in pairs(colors) do
    if vim.list_contains(labels, k) then
      res[k] = string.format("#%06x", v)
    else
      res[k] = v
    end
  end
  return res
end

---Extend table for highlight definitions for `nvim_set_hl`.
---@param group string
---@param tbl table
---@return table
M.extend_hl = function(group, tbl)
  local colors = M.get_highlights(group)
  return vim.tbl_extend("force", colors, tbl)
end

---Wrapper for `nvim_set_hl` that applies higroups from table definitions.
---@param colors table|fun(): table
M.set_hl = function(colors)
  if type(colors) == "function" then
    colors = colors()
  end
  for group, hl in pairs(colors) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

---Registers an autocmd to set highlights on `ColorScheme` event.
---@param name string? Name of the colorscheme for the autocmd pattern; use `"*"` or `nil` to match all colorschemes.
---@param colors table<string, table> Table of highlight definitions (e.g., { Normal = { fg = "#ffffff", bg = "#000000" } }).
M.set_hl_autocmd = function(name, colors)
  local pattern = name or "*"
  M._hl_cache = vim.tbl_deep_extend("force", M._hl_cache or {}, { [pattern] = colors })
  vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
    desc = ("Apply highlight overrides for colorscheme: %s"):format(pattern),
    group = vim.api.nvim_create_augroup(("ColorScheme#%s"):format(pattern), { clear = true }),
    pattern = pattern,
    callback = function()
      M.set_hl(M._hl_cache[pattern])
    end,
  })
end

---Get filepath for matching colorscheme name in `after/colors` directory.
---@param name string Name of the desired colorscheme.
---@param rtp string Parent directory to search for runtime files.
---@return string?
local get_colors_file = function(name, rtp)
  local files = vim.api.nvim_get_runtime_file(rtp .. "/*", true)
  for _, path in pairs(files) do
    local match = string.match(path, rtp .. "/(%w+)%.[lua|vim]")
    if match == name then
      return path
    end
  end
end

---Load colorscheme from runtime path: `after/colors`
---@param name string Name of the desired colorscheme.
M.load = function(name)
  local filepath = get_colors_file(name, "after/colors")

  -- Match extension for loading vimscript files
  if filepath and filepath:match(".+%.vim") then
    vim.cmd.source(filepath)
  end

  -- Safely load lua file for theme highlights
  local theme_ok, theme = pcall(dofile, filepath)
  if theme_ok and type(theme) == "table" then
    M.set_hl(theme["colors"] or {})
  end

  -- Apply global highlights variable for all colorschemes.
  if vim.g.colors then
    M.set_hl(vim.g.colors or {})
  end
end

--- Autocmds ---

local group = vim.api.nvim_create_augroup("ColorSchemeFix", {})

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  desc = "Automatically load/reload colorscheme changes",
  group = group,
  callback = function(ev)
    M.load(vim.g.colors_name and ev.match or "default")
  end,
})

vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
  desc = "Unset global terminal color variables before changing colorscheme",
  group = group,
  callback = function()
    for i = 0, 15 do
      vim.g["terminal_color_" .. i] = nil
    end
  end,
})

return M
