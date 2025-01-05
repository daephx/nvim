-- flatten.nvim | Open files from terminal buffers without creating a nested session
-- https://github.com/willothy/flatten.nvim

---@type LazySpec
return {
  "willothy/flatten.nvim",
  -- Disable lazy-loading to ensure that it runs first.
  -- This should minimize delay when opening file from terminal
  lazy = false,
  priority = 1001,
  opts = {
    window = { open = "alternate" },
  },
}
