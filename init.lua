--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
--
-- File: init.lua
-- Description: Personal configuration files for NeoVim!
-- These settings are designed to fit my preferences/workflow,
-- feel free to take what you like from them, no worries.
-- Just don't copy them wholesale, figure out what works for you!
--
-- NOTE: Currently a work-in-progress, Use at your own risk...

--- Initialization ---

-- Abbreviations
local cmd, env = vim.cmd, vim.env
local fn, g = vim.fn, vim.g

-- Environement variable for config directory
-- This is just nice to have for opening files.
env.MYRUNTIME = fn.stdpath('config')


--- Settings ---

g.colors_name = 'tokyonight'


--- Helpers ---

-- Useful functions and auto-commands!
-- These are must haves, other settings and plugins
-- will likely exist in external locations.

cmd([[
augroup DaephxSolutions
  autocmd!

  " Auto-sourcing Configurations
  autocmd BufWritePost,SourcePost $MYVIMRC :so $MYVIMRC
    \ | redraw | echom 'Sourcing $MYVIMRC: ' . $MYVIMRC

  " File cleaning operations | ORDER MATTERS
  autocmd BufWritePre * %s/\s\+$//e   " Remove trailing whitespace
  autocmd BufWritePre * %s/\n\+\%$//e " Remove trailing newlines

  " Minimal autosave implementation
  autocmd CursorHold,CursorHoldI * silent! update
  autocmd FocusLost * silent! wall " Write all on focus loss

  " Disable relative numbers in insert mode
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber

  " Clear the search highlight after 'updatetime'
  autocmd CursorHold,CursorHoldI * let @/ = ''

augroup END
]])
