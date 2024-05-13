-- satellite.nvim | Decorate scrollbar for Neovim
-- https://github.com/lewis6991/satellite.nvim

---@type LazyPluginSpec
return {
  "https://github.com/lewis6991/satellite.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = true,
}
