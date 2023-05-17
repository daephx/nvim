--     ____  __            _
--    / __ \/ /_  ______ _(_)___  _____
--   / /_/ / / / / / __ `/ / __ \/ ___/
--  / ____/ / /_/ / /_/ / / / / (__  )
-- /_/   /_/\__,_/\__, /_/_/ /_/____/
-- ==============/____/================
-- Plugin manager definitions & configs

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize plugin list
require("lazy").setup({

  -- NOTE: Temporarily defining spec returns until all are migrated

  require("plugins.autopairs"),
  require("plugins.barbecue"),
  require("plugins.cmp"),
  require("plugins.colorizer"),
  require("plugins.colors"),
  require("plugins.comment"),
  require("plugins.dap"),
  require("plugins.dashboard"),
  require("plugins.editorconfig"),
  require("plugins.git"),
  require("plugins.hex"),
  require("plugins.hop"),
  require("plugins.indent_blankline"),
  require("plugins.lsp"),
  require("plugins.lualine"),
  require("plugins.luasnip"),
  require("plugins.markdown"),
  require("plugins.mason"),
  require("plugins.neorg"),
  require("plugins.nvim-tree"),
  require("plugins.project_nvim"),
  require("plugins.session"),
  require("plugins.telescope"),
  require("plugins.todo-comments"),
  require("plugins.toggleterm"),
  require("plugins.treesitter"),
  require("plugins.trouble"),
  require("plugins.unception"),
  require("plugins.undotree"),
  require("plugins.vim-dirtytalk"),
  require("plugins.which-key"),
  require("plugins.zen-mode"),
}, {
  defaults = { lazy = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = vim.g.border,
  },
})

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Prevent lazy lockfile from being modified",
  pattern = "lazy-lock.json",
  command = "setlocal readonly",
})
