-- vim-dirtytalk | Spellcheck dictionary for programmers
-- https://github.com/psliwka/vim-dirtytalk

---@type LazySpec
return {
  "psliwka/vim-dirtytalk",
  build = ":DirtytalkUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.opt.spelllang:append("programming")
  end,
}
