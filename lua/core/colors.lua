--    ______      __
--   / ____/___  / /___  __________
--  / /   / __ \/ / __ \/ ___/ ___/
-- / /___/ /_/ / / /_/ / /  (__  )
-- \____/\____/_/\____/_/  /____/
-- ================================
-- Load colorscheme from lua module

local M = {}

-- Check if main color scheme file is available in the current runtimepath
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

-- Get color table from highlight group with optional section: fg, bg
---@param group string
---@param hl string|nil
---@return table
M.get_highlights = function(group, hl)
  local labels = { background = "bg", foreground = "fg", special = "sp" }
  local tbl = vim.api.nvim_get_hl_by_name(group, hl or "")
  local res = {}
  for k, v in pairs(tbl) do
    local label = labels[k]
    if label ~= nil then
      res[label] = string.format("#%06x", v)
    else
      res[k] = v
    end
  end
  return res
end

-- Extend table for highlight definitions for nvim_set_hl
---@param group string
---@param tbl table
---@return table
M.extend_highlights = function(group, tbl)
  local colors = M.get_highlights(group)
  return vim.tbl_extend("force", colors, tbl)
end

-- Wrapper for nvim_set_hl that applies higroups from table definitions
---@param opts function|table
M.set_highlights = function(opts)
  if type(opts) == "function" then
    opts = opts() ---@type table
  end
  for group, colors in pairs(opts) do
    vim.api.nvim_set_hl(0, group, colors)
  end
end

---Get filepath for matching colorscheme name in after/colors directory.
---@param name string # Name of the desired colorscheme
---@param rtp string # Parent directory to search for runtime files
---@return string|nil # Path string to first matching runtime file
local get_colors_file = function(name, rtp)
  local files = vim.api.nvim_get_runtime_file(rtp .. "/*", true)
  for _, path in pairs(files) do
    local match = string.match(path, rtp .. "/(%w+)%.[lua|vim]")
    if match == name then
      return path
    end
  end
end

---Load colorscheme from runtime path.
---@param name string # Name of the desired colorscheme
local load = function(name)
  local rtp = "lua/plugins/colors"
  local filepath = get_colors_file(name, rtp) or ""

  -- Match extension for loading vimscript files
  if filepath:match(".+%.vim") then
    vim.cmd.source(filepath)
  end

  -- Safely load lua file for theme highlights
  local theme_ok, theme = pcall(dofile, filepath)
  if theme_ok and type(theme) == "table" then
    M.set_highlights(theme["colors"] or {})
  end

  -- Apply global highlights variable for all colorschemes
  if vim.g.colors then
    M.set_highlights(vim.g.colors or {})
  end
end

--- Autocmds ---

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  desc = "Load/Reload color scheme module when colorscheme changes",
  group = vim.api.nvim_create_augroup("ColorSchemeOverrides", {}),
  callback = function(ev)
    load(ev.match)
  end,
})

return M
