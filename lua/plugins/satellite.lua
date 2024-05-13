-- satellite.nvim | Decorate scrollbar for Neovim
-- https://github.com/lewis6991/satellite.nvim
---@module "satellite"

---@type LazyPluginSpec
return {
  "lewis6991/satellite.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = true,
}
