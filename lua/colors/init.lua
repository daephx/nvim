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

local g = vim.g

local global = require('colors.global')
local utils = require('colors.utils')

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
    utils.setup(colorscheme.highlights)
  end

  -- Apply global overrides
  utils.setup(global.highlights)

  -- Update Colorscheme
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
