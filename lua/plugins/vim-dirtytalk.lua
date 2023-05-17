-- vim-dirtytalk | Spellcheck dictionary for programmers
-- https://github.com/psliwka/vim-dirtytalk

return {
  "psliwka/vim-dirtytalk",
  build = ":DirtytalkUpdate",
  event = "VeryLazy",
  config = function()
    -- Append site directory to rtp for lazy
    vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site")
    vim.opt.spelllang:append("programming")
  end,
}
