-- Diffview.nvim | tabpage interface for easily cycling through diffs
-- https://github.com/sindrets/diffview.nvim

---@type LazyPluginSpec
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = true,
}
