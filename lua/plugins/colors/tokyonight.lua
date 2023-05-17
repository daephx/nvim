-- tokyonight.nvim | A clean, dark Neovim theme written in Lua
-- https://github.com/folke/tokyonight.nvim

return {
  "folke/tokyonight.nvim",
  lazy = false,
  opts = {
    style = "night",
    day_brightness = 0.3,
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
      functions = {},
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    sidebars = {
      "NvimTree",
      "Touble",
      "floaterm",
      "help",
      "neotree",
      "nerdtree",
      "packer",
      "qf",
      "terminal",
      "toggleterm",
      "vista_kind",
    },
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param c ColorScheme
    on_colors = function(c)
      c.hint = c.orange
      c.gitSigns.change = "#7F6526"
    end,
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param hl Highlights
    ---@param c ColorScheme
    on_highlights = function(hl, _)
      hl.FoldColumn = { bg = "none" }
      hl.String = { fg = "#cbaa73" }
      hl.VertSplit = { fg = "#39394e" }
      hl.WhichKeyFloat = { link = "StatusLineNC" }
      hl.NormalFloat = { link = "Normal" }

      hl.TelescopePreviewBorder = { link = "VertSplit" }
      hl.TelescopePromptBorder = { link = "VertSplit" }
      hl.TelescopeResultsBorder = { link = "VertSplit" }
    end,
  },
}
