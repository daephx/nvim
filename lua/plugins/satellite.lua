-- satellite.nvim | Decorate scrollbar for Neovim
-- https://github.com/lewis6991/satellite.nvim
---@module "satellite"

---@type LazyPluginSpec
return {
  "lewis6991/satellite.nvim",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    -- Apply highlight group values for plugin on ColorScheme change.
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      SatelliteBar = { link = "Pmenu", default = true },
    })
  end,
  opts = {
    -- HACK: Disable winblend to prevent black background
    -- https://github.com/neovim/neovim/issues/18576
    winblend = 0,
    handlers = {
      gitsigns = { enable = false },
    },
  },
}
