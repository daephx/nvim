-- Diffview.nvim | tabpage interface for easily cycling through diffs
-- https://github.com/sindrets/diffview.nvim

---@type LazyPluginSpec
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "DiffView" },
  },
  config = true,
}
