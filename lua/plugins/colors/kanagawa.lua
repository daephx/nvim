-- kanagawa.nvim | dark colorscheme inspired by famous painting of Katsushika Hokusai
-- https://github.com/rebelot/kanagawa.nvim

---@type LazyPluginSpec
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
    colors = {
      theme = {
        all = {
          ui = {
            -- Remove the background of LineNr, {Sign,Fold}Column and friends!
            -- Only applies when transparent is enabled.
            bg_gutter = "NONE",
          },
        },
      },
    },
    overrides = function(colors) -- Add/Modify highlights
      local theme = colors.theme
      return {
        NormalFloat = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
        CursorLine = { bg = theme.ui.bg_dim },
        WinSeparator = { fg = theme.ui.bg_p1 },

        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        TelescopeNormal = { bg = "NONE" },
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptBorder = { fg = theme.ui.bg_p1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1 },
        TelescopePreviewBorder = { fg = theme.ui.bg_dim },

        WhichKeyFloat = { bg = theme.ui.bg_dim },
      }
    end,
  },
}
