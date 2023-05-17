-- lazy.nvim | A modern plugin manager for Neovim
-- https://github.com/folke/lazy.nvim

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
  spec = "plugins",
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
