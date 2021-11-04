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
  if ok and colorscheme.overrides then
    colorscheme.overrides()
  end

  -- All highlight overrides MUST be executed after colorscheme Initialization
  local overrides = require('colors.overrides')
  overrides.GeneralOverrides() -- Unstructed highlight tweaks
  overrides.TransparentBackground() -- Disable 'Normal' higroup

    }
  }

  api.nvim_echo({
    {'Loaded Colorscheme: ', 'constant'},
    {name, 'None'}},
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
