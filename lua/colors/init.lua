--    ______      __
--   / ____/___  / /___  __________
--  / /   / __ \/ / __ \/ ___/ ___/
-- / /___/ /_/ / / /_/ / /  (__  )
-- \____/\____/_/\____/_/  /____/
-- ================================
-- init module for loading colorschemes
-- and overrides for common highlight groups

local api = vim.api
local cmd = vim.cmd
local g = vim.g

-- local highlight = vim.api.nvim_set_hl

local M = {}

function M.setup(name)
  -- Check for colorscheme definitions
  local ok, colorscheme = pcall(require, "colors."..name)
  if name ~= g.colors_name then
    return
  end

  -- Load colorscheme
  cmd('colorscheme ' .. name)

  -- Load colorscheme specific overrides
  if ok and colorscheme.highlights then
    colorscheme.highlights()
  end

  -- General highlight overrides
  require('colors.overrides').setup({
    transparent_background = true,
    highlights = {
      Comment = {ui = 'NONE'},
      NonText = {bg = 'NONE'},
      Question = {bg = 'NONE'},
      -- CursorLine = {link = 'LineNr'}, -- Needs partial, no foreground
      CursorLineNr = { link = 'number' },
      Directory = {bg = 'NONE'},

      SignColumn = {bg = 'NONE'},

      -- Gitsigns Link Colors
      GitSignsAdd = {link = 'DiffAdd'},
      GitSignsChange ={link = 'DiffChange'},
      GitSignsDelete = {link = 'DiffDelete'},
    }
  })

  -- Completion Message
  api.nvim_echo({
    {'Loaded colorscheme: ', 'Special'},
    {name, 'none'}},
    true, {}
  )

  -- Define colorscheme autogroup
  -- Reload this function when colorscheme is updated

  cmd [[
  augroup colorscheme_au
    autocmd!
    autocmd ColorScheme *
      \ lua require('colors').setup(vim.g.colors_name)
  augroup end
  ]]

end

return M
