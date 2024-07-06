-- tokyonight.nvim | A clean, dark Neovim theme written in Lua
-- https://github.com/folke/tokyonight.nvim
---@module "tokyonight"

---@type LazyPluginSpec
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = true, -- Enable this to disable setting the background color
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = false },
      keywords = { italic = false },
      -- Background styles. Can be "dark", "transparent" or "normal"
      floats = "transparent", -- style for floating windows
      sidebars = "transparent", -- style for sidebars
    },
    ---You can override specific color groups to use other groups or a hex color
    ---function will be called with a ColorScheme table
    ---@param c ColorScheme
    on_colors = function(c)
      c.hint = c.orange
    end,
    ---You can override specific highlights to use other groups or a hex color
    ---function will be called with a Highlights and ColorScheme table
    ---@param hl tokyonight.Highlights
    ---@param _c ColorScheme
    on_highlights = function(hl, _c)
      hl.NormalFloat = { link = "Normal" }
      hl.WinSeparator = { fg = "#39394e" }
      hl.VertSplit = { link = "WinSeparator" }

      -- Telescope
      hl.TelescopeSelection = { link = "PmenuSel" }
      hl.TelescopePreviewBorder = { link = "WinSeparator" }
      hl.TelescopePromptBorder = { link = "WinSeparator" }
      hl.TelescopeResultsBorder = { link = "WinSeparator" }

      -- Treesitter
      hl.TreesitterContext = { bg = "none" }

      -- Whichkey
      hl.WhichKeyFloat = { link = "StatusLineNC" }
    end,
  },
}
