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

local M = {}

--- Utilities ---

--@param  group  : string = 'DiffAdd'
--@param  colors : table  = {'fg', 'gui'}
--@return color  : string = '#10e010'
function M.getHighlight(group, term)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), unpack(term))
end

function M.getHighlightTable(group)
  local output = fn.execute('hi ' .. group)
  local list = fn.split(output, '\\s\\+')

  local dict = {}
  for _, item in pairs(list) do
    if fn.match(item, '=') > 0 then
      local splited = fn.split(item, '=')
      dict[splited[1]] = splited[2]
    end
  end
  return dict
end

-- TODO: Allow extraction of linked values and overwriting, aka partialLinks
--@param group  : string = 'DiffAdd'
--@param colors : table  = {fg = '#10e010'}
function M.setHighlight(group, colors)
  local bg = colors.bg and 'guibg=' .. colors.bg or ''
  local fg = colors.fg and 'guifg=' .. colors.fg or ''
  local sp = colors.sp and 'guisp=' .. colors.sp or ''
  local ui = colors.ui and 'gui=' .. colors.ui or ''

  local hl = 'silent highlight ' .. table.concat({ group, bg, fg, sp, ui }, ' ')

  if colors.clear == true then
    vim.cmd('highlight clear ' .. group)
    return
  end
  if colors.link then
    link = table.concat({ 'link', group, colors.link }, ' ')
    vim.cmd('highlight! ' .. link)
  end
  vim.cmd(hl)
end

-- @param opts : { group = { fg = 'red', bg = 'blue' } }
function M.applyHighlights(opts)
  local next = next
  opts = type(opts) == 'function' and opts() or opts
  for group, colors in pairs(opts) do
    if next(colors) ~= nil then
      M.setHighlight(group, colors)
    end
  end
end

--- Initialization ---

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
    M.applyHighlights(colorscheme.highlights)
  end

  -- Apply global overrides
  M.applyHighlights(global.highlights)

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
