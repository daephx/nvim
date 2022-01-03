--    ______      __
--   / ____/___  / /___  __________
--  / /   / __ \/ / __ \/ ___/ ___/
-- / /___/ /_/ / / /_/ / /  (__  )
-- \____/\____/_/\____/_/  /____/
-- ================================
-- init module for loading colorschemes
-- and overrides for common highlight groups

-- This module manages colorscheme settings via globals and higroups
-- You should set your colorscheme prior to sourcing this module
-- either with `colorscheme <name>` or `vim.g.colors_name = <name>`

-- You can also call this function when loading plugins
-- with the name of a theme that matches a file in `lua/colors/<name>.lua`
-- This file will be loaded with your theme settings.
-- it will also attempt to execute a module function called `override`
-- where you can define custom highlights to be applied afterward.

local g = vim.g

local M = {}

function M.setup(name)
  -- Check for colorscheme definition module
  local ok, colorscheme = pcall(require, 'colors.' .. name)
  if name ~= g.colors_name then
    return
  end

  -- Load colorscheme
  vim.cmd('colorscheme ' .. name)

  -- Load colorscheme specific overrides
  if ok and colorscheme.highlights then
    colorscheme.highlights()
  end

  -- General highlight overrides
  require('colors.overrides').setup({
    transparent_background = true,
    highlights = {
      Comment = { ui = 'NONE' },
      NonText = { bg = 'NONE' },
      Question = { bg = 'NONE' },
      -- CursorLine = {link = 'LineNr'}, -- Needs partial, no foreground
      CursorLineNr = { link = 'number' },
      Directory = {bg = 'NONE'},
      VertSplit = {bg = 'NONE'},

      SignColumn = { bg = 'NONE' },

      -- Gitsigns Link Colors
      GitSignsAdd = {link = 'DiffAdd'},
      GitSignsChange ={link = 'DiffChange'},
      GitSignsDelete = {link = 'DiffDelete'},

      -- Remove background from VirtualText
      DiagnosticVirtualTextHint = {bg = 'NONE'},
      DiagnosticVirtualTextInfo = {bg = 'NONE'},
      DiagnosticVirtualTextWarn = {bg = 'NONE'},
      DiagnosticVirtualTextError = {bg = 'NONE'},
    }
  })

  -- Define colorscheme autogroup
  -- Reload this function when colorscheme is updated

  vim.cmd([[
  augroup colorscheme_au
    autocmd!
    autocmd ColorScheme *
      \ lua require('colors').setup(vim.g.colors_name)
  augroup end
  ]])
end

return M
