-- vim-dirtytalk | Spellcheck dictionary for programmers
-- https://github.com/psliwka/vim-dirtytalk

return {
  "psliwka/vim-dirtytalk",
  build = ":DirtytalkUpdate",
  event = "VeryLazy",
  config = function()
    vim.opt.spelllang:append("programming")
  end,
}
