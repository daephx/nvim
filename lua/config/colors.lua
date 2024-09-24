-- colors.lua: Utility for managing and customizing Neovim colorschemes
--
-- Provides functions to load colorschemes, manage highlight groups,
-- and apply custom highlight definitions dynamically during ColorScheme events.
-- Supports autocommands to ensure custom highlights are re-applied when changing themes.

---@alias config.HighlightsTbl table<string, vim.api.keyset.highlight>
---@alias config.HighlightsFn fun(hl?: config.HighlightsTbl): nil
---@alias config.Highlights config.HighlightsTbl|config.HighlightsFn

local M = {}

---Check if colorscheme filename is available in the runtimepath
---@param name string
---@return boolean
M.check_colorscheme_exists = function(name)
  for _, path in pairs(vim.api.nvim_get_runtime_file("colors/*.*", true)) do
    local basename = string.match(path, "/colors/(%w+)%.[lua|vim]")
    local is_after = string.match(path, "/after/colors/")
    -- Ensure the path does not located in the `after/` directory.
    if basename and basename == name and not is_after then
      return true
    end
  end
  return false
end

---Get color table from highlight group.
---@param name string higroup name.
---@return config.HighlightsTbl
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
---@param colors config.HighlightsTbl
---@return config.HighlightsTbl
M.extend_hl = function(group, colors)
  local group_colors = M.get_highlight(group)
  return vim.tbl_extend("force", group_colors, colors)
end

---Wrapper for nvim_set_hl that applies higroups from table/func definitions.
---@param colors config.Highlights
---@return nil
M.set_hl = function(colors)
  local ret = {}
  if type(colors) == "function" then
    colors(ret)
  elseif type(colors) == "table" then
    ret = colors
  end
  for group, hl in pairs(ret) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

---Registers an autocmd to set highlights on `ColorScheme` event.
---@param name string? Name of the colorscheme for the autocmd pattern; use `"*"` or `nil` to match all colorschemes.
---@param colors config.Highlights Table of highlight definitions.
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

---Load highlight overrides for the specified colorscheme and apply global overrides.
---@param name string Colorscheme name used to look for a matching `after/colors` module.
---@return nil
M.load_after_colors = function(name)
  local filepath
  if name then
    filepath = get_colors_file(name, "after/colors")
  end

  -- Match extension for loading vimscript files
  if filepath and filepath:match(".+%.vim") then
    vim.cmd.source(filepath)
  end

  -- Load lua file for theme highlights
  if filepath and filepath:match(".+%.lua") then
    M.set_hl(dofile(filepath) or {})
  end

  -- Apply global highlights variable for all colorschemes.
  if vim.g.colors then
    M.set_hl(vim.g.colors or {})
  end
end

---Persist and restore colorscheme across sessions
---This function sets up autocommands to save the current colorscheme in a
---global variable and reload it when Neovim starts.
---@return nil
M.persist_colorscheme = function()
  local group = vim.api.nvim_create_augroup("ColorScheme#Persist", { clear = true })
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    desc = "Save current colorscheme to an environment variable",
    group = group,
    callback = function(ev)
      vim.g.COLORSCHEME = ev.match
    end,
  })
  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    desc = "Restore the saved global colorscheme on startup",
    group = group,
    nested = true,
    callback = function()
      pcall(vim.cmd.colorscheme, vim.g.COLORSCHEME or "default")
    end,
  })
end

---Enable automatic reloading of colorscheme changes
---This function sets up autocommands for reloading the colorscheme when
---the ColorScheme or VimEnter events are triggered.
---@return nil
M.hook_colorscheme_change = function()
  vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
    desc = "Load custom highlight definitions from after/colors matching the active colorscheme",
    group = vim.api.nvim_create_augroup("ColorScheme#AfterColors", { clear = true }),
    callback = function()
      M.load_after_colors(vim.g.colors_name)
    end,
  })
end

---Fix terminal color variables when changing colorscheme
---This function sets up an autocommand to unset global terminal color
---variables before a colorscheme change to prevent issues with terminal colors.
---@return nil
M.reset_terminal_colors = function()
  vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
    desc = "Clear terminal color variables before applying a new colorscheme",
    group = vim.api.nvim_create_augroup("ColorScheme#ClearTermColros", { clear = true }),
    callback = function()
      for i = 0, 15 do
        vim.g["terminal_color_" .. i] = nil
      end
    end,
  })
end

---Sets default semantic highlight groups for LSP types and clears any comment-related
---highlights on token updates. This helps ensure consistent styling by linking LSP
---types to existing highlight groups and removing unnecessary comment highlights.
---@return nil
M.refresh_lsp_highlights = function()
  -- Set defaults for semantic highlights
  local links = {
    ["@lsp.type.class"] = "@type",
    ["@lsp.type.decorator"] = "@function",
    ["@lsp.type.enum"] = "@type",
    ["@lsp.type.enumMember"] = "@constant",
    ["@lsp.type.function"] = "@function",
    ["@lsp.type.interface"] = "@type",
    ["@lsp.type.macro"] = "@macro",
    ["@lsp.type.method"] = "@method",
    ["@lsp.type.namespace"] = "@namespace",
    ["@lsp.type.parameter"] = "@parameter",
    ["@lsp.type.property"] = "@property",
    ["@lsp.type.struct"] = "@structure",
    ["@lsp.type.type"] = "@type",
    ["@lsp.type.variable"] = "@variable",
  }
  for new_hlgroup, old_hlgroup in pairs(links) do
    vim.api.nvim_set_hl(0, new_hlgroup, { link = old_hlgroup, default = true })
  end

  vim.api.nvim_create_autocmd("LspTokenUpdate", {
    desc = "Clear all comment associated highlights when updating tokens",
    group = vim.api.nvim_create_augroup("LspTokenUpdate#DisableComments", { clear = true }),
    callback = function()
      -- NOTE: This could cause problems with luadocs
      -- Clear all lsp highlights associated with comment strings
      for _, group in ipairs(vim.fn.getcompletion("@lsp.type.comment", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  })
end

-- Initialize autocmds
M.hook_colorscheme_change()
M.persist_colorscheme()
M.refresh_lsp_highlights()
M.reset_terminal_colors()

return M
