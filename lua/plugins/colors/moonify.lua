--  vim-moonfly-colors | A dark charcoal theme for modern Neovim & classic Vim
-- https://github.com/bluz71/vim-moonfly-colors

---@type LazySpec
return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.moonflyCursorColor = true
    vim.g.moonflyItalics = false
    vim.g.moonflyNormalFloat = true
    vim.g.moonflyTransparent = true
    vim.g.moonflyUnderlineMatchParen = true
    vim.g.moonflyVirtualTextColor = true
    vim.g.moonflyWinSeparator = 2

    local palette = require("moonfly").palette
    local colors = require("config.colors")
    colors.set_hl_autocmd("moonfly", {
      CursorLineNr = { fg = palette.blue, bold = true },
      CursorLineSign = { link = "Normal" },
      FloatBorder = { fg = palette.grey39 },
      FoldColumn = { bg = "none", fg = palette.grey39 },
      Folded = { bg = palette.grey18, fg = palette.grey50 },
      MsgSeparator = { link = "WinSeparator" },
      NormalFloat = { fg = "#c6c6c6", bg = "#080808" },
      Pmenu = { link = "NormalFloat" },
      Underlined = { fg = palette.purple, underline = true },
      VertSplit = { link = "WinSeparator" },
      Visual = { bg = palette.bay },
      WinBar = { bg = "none" },
      WinBarNC = { bg = "none" },
      WinSeparator = { fg = palette.grey27 },

      -- Diff
      DiffAdd = { bg = "#2d3e38" },
      DiffChange = { bg = "#2e2e2e" },
      DiffDelete = { bg = "#542b2b", fg = palette.red },
      DiffText = { bg = "#313b5a" },

      -- Neogit
      NeogitDiffAdd = { bg = "#2d3e38", fg = palette.green },
      NeogitDiffChange = { bg = "#2e2e2e" },
      NeogitDiffDelete = { bg = "#542b2b", fg = palette.red },
      NeogitDiffText = { bg = "#313b5a", fg = "none" },

      -- Treesitter
      TreesitterContextBottom = {},
      ["@string.special.url"] = { link = "Underlined" },
    })
  end,
}
