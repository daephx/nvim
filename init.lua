--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-- ====================================
-- Personal Neovim configuration files

-- Define leader keys
vim.g.mapleader = " "
vim.g.localleader = "\\"

-- Load config modules
require("core")
require("plugins")
require("colors")

-- these highlight definitions apply after any color schemes.
vim.g.colors_overrides = {
  NormalFloat = { link = "Normal" },
}

-- Apply colorscheme
vim.cmd.colorscheme("vscode")
