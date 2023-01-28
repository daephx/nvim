--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-- ====================================
-- Personal Neovim configuration files

-- Define globals and leader keys
vim.g.mapleader = " "
vim.g.localleader = "\\"
vim.g.colors_name = "vscode"

-- Load config modules
require("plugins")
require("colors")
require("core")
