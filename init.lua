--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-- =====================================
-- File: init.lua
-- Description: Personal configuration files for NeoVim!
-- These settings are designed to fit my preferences/workflow,
-- feel free to take what you like from them, no worries.
-- Just don't copy them wholesale, figure out what works for you!

local env = vim.env
local fn = vim.fn
local g = vim.g

-- Environement variable for config directory
-- This is just nice to have for opening files
-- from other locations '$MYRUNTIME/init.lua'
env.MYRUNTIME = fn.stdpath('config')


--- Globals ---

-- Set colorscheme
g.colors_name = 'tokyonight'

-- Enable personal experimentals.
-- Sometimes this only contains one or two remaps
g.experiemental_on = 0

-- Set leaders
g.mapleader = ' '
g.localleader = '\\'


--- Modules ---

-- Lua modules containing configuration definitions
-- The order of these does matter!

require('settings') -- General NeoVim Settings


--- Helpers ---

-- Useful functions and auto-commands!
-- These are must haves, other settings and plugins
-- will likely exist in external locations.

cmd([[
augroup DaephxSolutions
  autocmd!

  " Auto-sourcing Configurations
  autocmd BufWritePost $MYVIMRC :so $MYVIMRC
    \ | redraw | echom 'Sourcing $MYVIMRC: ' . $MYVIMRC

  " File cleaning operations | ORDER MATTERS
  autocmd BufWritePre * %s/\s\+$//e   " Remove trailing whitespace
  autocmd BufWritePre * %s/\n\+\%$//e " Remove trailing newlines

  " Minimal autosave implementation
  autocmd CursorHold,CursorHoldI * silent! update
  autocmd FocusLost * silent! wall " Write all on focus loss

augroup END
]])
