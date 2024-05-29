-- flatten.nvim | Open files from terminal buffers without creating a nested session
-- https://github.com/willothy/flatten.nvim

---@type LazyPluginSpec
return {
  "willothy/flatten.nvim",
  event = { "TermOpen" },
  opts = {
    window = { open = "alternate" },
  },
}
