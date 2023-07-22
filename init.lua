--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-- ====================================
-- Personal Neovim configuration files
-- https://github.com/daephx/nvim

-- Load config modules
require("config.options")
require("config.filetypes")
require("config.commands")
require("config.keymaps")
require("config.autocmds")
require("config.terminal")
require("config.colors")
require("config.lazy")

-- Apply colorscheme
vim.cmd.colorscheme("vscode")
