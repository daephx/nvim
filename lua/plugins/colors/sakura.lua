-- Sakura.nvim | Nice color scheme for neovim
-- https://github.com/numToStr/Sakura.nvim

---@type LazyPluginSpec
return {
  "numtostr/sakura.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
  init = function()
    local colors = require("config.colors")
    colors.set_hl_autocmd("sakura", {
      NormalFloat = { link = "Normal" },
      FloatBorder = { fg = "#6e6a86" },
      CursorLineNr = { fg = "#f6c177" },
      SpecialChar = { fg = "#56b1bb" },
      String = { fg = "#cbaa73" },
    })
  end,
}
