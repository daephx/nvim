--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-- ====================================
-- Personal Neovim configuration files.

vim.g.debug = false

vim.g.mapleader = " "
vim.g.localleader = "\\"
vim.g.colors_name = "vscode"

if vim.g.is_neovide == 1 then
  vim.g.neovide_cursor_animation_length = 0.01
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_fullscreen = true
  vim.g.neovide_remember_window_size = true
end

require("core")
require("plugins")
require("colors")
