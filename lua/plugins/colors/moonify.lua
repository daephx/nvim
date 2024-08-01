--  vim-moonfly-colors | A dark charcoal theme for modern Neovim & classic Vim
-- https://github.com/bluz71/vim-moonfly-colors

---@type LazyPluginSpec
return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.moonflyCursorColor = true
    vim.g.moonflyItalics = false
    vim.g.moonflyNormalFloat = true
    vim.g.moonflyTransparent = true
    vim.g.moonflyUnderlineMatchParen = true
    vim.g.moonflyVirtualTextColor = true
    vim.g.moonflyWinSeparator = 2 -- Line separator

    local colors = require("config.colors")
    colors.set_hl_autocmd("moonfly", {
      -- General
      Boolean = { link = "MoonflySky" },
      Comment = { link = "MoonflyGrey241" },
      CursorLineNr = { link = "MoonflyBlue" },
      Function = { link = "MoonflyBlue", bold = true },

      -- Treesitter Rainbow
      TSRainbowRed = { link = "MoonflyRed" },
      TSRainbowBlue = { link = "MoonflyBlue" },
      TSRainbowCyan = { link = "MoonflySky" },
      TSRainbowGreen = { link = "MoonflyGreen" },
      TSRainbowOrange = { link = "MoonflyOrange" },
      TSRainbowViolet = { link = "MoonflyViolet" },
      TSRainbowYellow = { link = "MoonflyYellow" },

      -- Telescope
      TelescopeTitle = { link = "MoonflySky", bold = true },
      TelescopePromptBorder = { link = "MoonflyGrey241" },
      TelescopeResultsBorder = { link = "MoonflyGrey241" },
      TelescopePreviewBorder = { link = "MoonflyGrey241" },
    })
  end,
}
