--    ______      __
--   / ____/___  / /___  __________
--  / /   / __ \/ / __ \/ ___/ ___/
-- / /___/ /_/ / / /_/ / /  (__  )
-- \____/\____/_/\____/_/  /____/
-- ================================
-- Load colorscheme from lua module

local M = {}

-- These highlight definitions apply after any color schemes.
-- Allowing all themes to be overwritten.
M.global_overrides = {
  NormalFloat = { link = "Normal" },
}

--- Helpers ---

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
---@param hl? string
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
---@param opts function | table
M.set_highlights = function(opts)
  if type(opts) == "function" then
    ---@type table
    opts = opts()
  end
  for group, colors in pairs(opts) do
    vim.api.nvim_set_hl(0, group, colors)
  end
end

-- Load/Reload color scheme modules by name
---@param name? string
M.load = function(name)
  name = name or vim.g.colors_name
  if not M.is_available(name) then
    return
  end

  -- Reload colorscheme module
  local module_path = ("colors.%s"):format(name)
  if package.loaded[module_path] then
    package.loaded[module_path] = nil
  end

  -- Safety check for theme highlight table
  local theme_ok, theme = pcall(require, module_path)
  if theme_ok and type(theme) == "table" then
    if theme["highlights"] then
      M.set_highlights(theme.highlights)
    end
  end
end

local group = vim.api.nvim_create_augroup("ColorSchemeSetup", {})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  desc = "Load/Reload color scheme module when colorscheme changes",
  group = group,
  callback = function(opts)
    M.load(opts.match)
    M.set_highlights(M.global_overrides)
  end,
})

return M
