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
  spec = {
    { import = "plugins" },
    { import = "plugins.colors" },
    { import = "plugins.git" },
  },
  change_detection = { notify = false },
  defaults = { lazy = true },
  install = { colorscheme = { "vscode", "default" } },
  ui = { border = vim.g.border },
  dev = {
    path = "~/Projects",
    patterns = { "daephx" },
  },
  performance = {
    rtp = {
      paths = { vim.fn.stdpath("data") .. "/site" },
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
})

--- Keymaps ---

map("n", "<leader>pb", "<cmd>Lazy build<CR>", { desc = "Build plugins" })
map("n", "<leader>pc", "<cmd>Lazy clean<CR>", { desc = "Clean plugins" })
map("n", "<leader>ph", "<cmd>Lazy health<CR>", { desc = "Healthcheck plugins" })
map("n", "<leader>pl", "<cmd>Lazy show<CR>", { desc = "Show plugins" })
map("n", "<leader>pp", "<cmd>Lazy profile<CR>", { desc = "Profile plugins" })
map("n", "<leader>pr", "<cmd>Lazy restore<CR>", { desc = "Restore plugins" })
map("n", "<leader>ps", "<cmd>Lazy sync<CR>", { desc = "Sync plugins" })
map("n", "<leader>pu", "<cmd>Lazy update<CR>", { desc = "Update plugins" })

--- Autocmds ---

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Prevent formatting errors in neovim lazy lockfile",
  pattern = "lazy-lock.json",
  callback = function()
    vim.b.autoformat = false
    vim.b.editorconfig = false
    vim.bo.binary = true
    vim.bo.fixendofline = false
    vim.wo.spell = false
  end,
})
