-- satellite.nvim | Decorate scrollbar for Neovim
-- https://github.com/lewis6991/satellite.nvim

---@type LazyPluginSpec
return {
  "https://github.com/lewis6991/satellite.nvim",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    -- Apply highlight group values for plugin on ColorScheme change.
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      SatelliteBar = { link = "PMenu" },
    })
  end,
  opts = {
    -- FIX: Disable winblend to prevent black background
    -- https://github.com/neovim/neovim/issues/18576
    winblend = 0,
  },
}
