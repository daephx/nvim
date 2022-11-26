-- auto-session | A small automated session manager for Neovim
-- https://github.com/rmagatti/auto-session

--- Auto-Session ---

-- Auto Session takes advantage of Neovim's existing session management
-- capabilities to provide seamless automatic session management.

local auto_session_ok, auto_session = pcall(require, 'auto-session')
if not auto_session_ok then
  return
end

auto_session.setup({
  auto_restore_enabled = true,
  auto_save_enabled = true,
  auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
  auto_session_suppress_dirs = { '/', '~/', '~/Documents', '~/Downloads', '~/Projects' },
  bypass_session_save_file_types = false,
})

-- session-lens | extension for auto-session and Telescope
-- https://github.com/rmagatti/session-lens

--- Session-Lens ---

-- Session Lens is a companion plugin to auto-session built on top of
-- Telescope.nvim for easy switching between existing sessions.

local telescope_ok, _ = pcall(require, 'telescope')
if not telescope_ok then
  return
end

local session_lens_ok, session_lens = pcall(require, 'session-lens')
if not session_lens_ok then
  return
end

local themes = require('telescope.themes')
session_lens.setup({
  prompt_title = 'Sessions',
  previewer = false,
  theme_conf = {
    theme = themes.get_ivy(),
    border = true,
  },
})

--- Keymaps ---

vim.keymap.set('n', '<leader>sf', function()
  session_lens.search_session()
end, { desc = 'Show Session list' })