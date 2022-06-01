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
require('settings') -- General Neovim Settings
require('filetypes') -- Filetype associations
require('utils') -- General utility functions
require('commands') -- Command abbreviations
require('mappings') -- Hotkey remaps

--- Helpers ---

-- Auto-Toggle tmux status line
-- Check if the TMUX environment variable exists

vim.cmd([[
  " Set to 0 to disable
  let g:tmux_toggle_statusbar = 1
  function! TmuxToggleStatusbar(toggle)
    if !exists('g:tmux_toggle_statusbar') | return | endif
    silent exe '!tmux set -g status ' . a:toggle
  endfunction

  augroup tmux_statusbar
    autocmd!
    autocmd VimEnter * call TmuxToggleStatusbar('off')
    autocmd VimLeave * call TmuxToggleStatusbar('on')
  augroup END
]])

-- Useful auto-commands that make life easier
-- These should always be available!

vim.cmd([[
augroup vimrc_au
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

  " Display highlight for a short moment when yanking text
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()

augroup END
]])
