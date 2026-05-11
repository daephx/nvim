-- Configuration for snacks.nvim zen mode module (distraction-free writing)
-- Main configuration is in lua/plugins/snacks/init.lua
-- https://github.com/folke/snacks.nvim/blob/main/docs/zen.md

---@type LazySpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<c-w>z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "<c-w>Z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
  },
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    zen = {
      enabled = true,
      toggles = {
        diagnostics = false,
        dim = false,
        git_signs = true,
        indent = true,
        line_number = false,
        relative_number = false,
        signcolumn = "no",
        ufo = true,
      },
    },
  },
}
