-- Configuration for snacks.nvim indent module (indentation guides & scope highlighting)
-- Main configuration is in lua/plugins/snacks/init.lua
-- https://github.com/folke/snacks.nvim/blob/main/docs/indent.md

---@type LazySpec
return {
  "snacks.nvim",
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    indent = {
      animate = {
        enabled = false,
      },
      scope = {
        underline = true,
        only_current = true,
        hl = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      },
    },
  },
}
