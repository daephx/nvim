-- git-conflict.nvim | Visualise and resolve merge conflicts in neovim
-- https://github.com/akinsho/git-conflict.nvim

---@type LazySpec
return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    default_mappings = true,
    disable_diagnostics = true,
  },
}
