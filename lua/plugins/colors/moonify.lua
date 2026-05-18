--  vim-moonfly-colors | A dark charcoal theme for modern Neovim & classic Vim
-- https://github.com/bluz71/vim-moonfly-colors

local terminal = {
  "#141414",
  "#ff5454",
  "#8cc85f",
  "#e3c78a",
  "#80a0ff",
  "#cf87e8",
  "#79dac8",
  "#c6c6c6",
  "#474747",
  "#ff5189",
  "#36c692",
  "#c6c684",
  "#74b2ff",
  "#ae81ff",
  "#85dc85",
  "#e4e4e4",
}

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
      -- General
      CursorLineNr = { fg = palette.blue, bold = true },
      CursorLineSign = { link = "Normal" },
      FloatBorder = { fg = palette.grey39 },
      FoldColumn = { bg = "none", fg = palette.grey39 },
      Folded = { bg = palette.grey18, fg = palette.grey50 },
      MsgSeparator = { link = "WinSeparator" },
      NormalFloat = { fg = "#c6c6c6", bg = "#080808" },
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

      -- Treesitter Rainbow
      RainbowDelimiterBlue = { fg = palette.blue },
      RainbowDelimiterCyan = { fg = palette.sky },
      RainbowDelimiterGreen = { fg = palette.green },
      RainbowDelimiterOrange = { fg = palette.orange },
      RainbowDelimiterRed = { fg = palette.red },
      RainbowDelimiterViolet = { fg = palette.violet },
      RainbowDelimiterYellow = { fg = palette.yellow },
    })
  end,
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      desc = "Replace terminal colors for colorscheme: moonfly",
      group = vim.api.nvim_create_augroup("ColorScheme#MoonflyTerminal", { clear = true }),
      pattern = "moonfly",
      callback = function()
        for i, color in ipairs(terminal) do
          vim.g["terminal_color_" .. i - 1] = color
        end
      end,
    })
  end,
}
