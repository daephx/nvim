--     _   __                _
--    / | / /__  ____ _   __(_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-- ====================================
-- Personal Neovim configuration files
-- https://github.com/daephx/nvim

-- Load core modules
require("core.options")
require("core.filetypes")
require("core.commands")
require("core.keymaps")
require("core.autocmds")
require("core.terminal")
require("core.colors")
require("core.lazy")

-- these highlight definitions apply after any color schemes.
vim.g.colors = {
  NormalFloat = { link = "Normal" },
}

-- Apply colorscheme
vim.cmd.colorscheme("vscode")
