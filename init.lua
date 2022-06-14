--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-- =====================================
-- File: init.lua
-- Description: Personal configuration files for Neovim!
-- These settings are designed to fit my preferences/workflow,
-- feel free to take what you like from them, no worries.
-- Just don't copy them wholesale, figure out what works for you!

local env = vim.env
local fn = vim.fn
local g = vim.g

-- Environment variable for config directory
-- This is just nice to have for opening files
-- from other locations '$MYRUNTIME/init.lua'
env.MYRUNTIME = fn.stdpath('config')

--- Globals ---

-- VSCode
-- These settings are specific to running Neovim
-- with the embedded vscode compatibility extension
if g.is_vscode == 1 then
  -- Disable plugins for external editor 'VSCode'
  vim.cmd('filetype indent plugin off')
  return
end

-- Neovide
-- Neovide is a graphical neovim client written in rust
-- These variables are set when launching the application
-- and allows us to add some extra settings.
if g.is_neovide == 1 then
  g.neovide_fullscreen = true
  g.neovide_cursor_vfx_mode = 'pixiedust'
end

-- Set colorscheme
g.colors_name = 'vscode'

-- Set leader keys
g.mapleader = ' '
g.localleader = '\\'

--- Modules ---

-- Lua modules containing configuration definitions
-- The order of these does matter!

require('plugins') -- Plugin definitions
require('colors') -- Pretty rainbows!!
require('options') -- General Neovim Settings
require('filetypes') -- Filetype associations
require('utils') -- General utility functions
require('commands') -- Command abbreviations
require('keymaps') -- Remapped hotkeys
require('autocmds') -- Auto commands
