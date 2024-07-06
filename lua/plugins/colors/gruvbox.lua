-- Lua port of the most famous vim colorscheme
-- https://github.com/ellisonleao/gruvbox.nvim

---@type LazyPluginSpec
return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    contrast = "hard", -- can be "hard", "soft" or empty string
    inverse = false, -- invert background for search, diffs, statusline and errors
    transparent_mode = true,
    bold = false,
    italic = {
      comments = false,
      folds = false,
      operators = false,
      strings = false,
    },
    palette_overrides = {},
    overrides = {
      -- General
      CursorLineNr = { bg = "none" },
      ErrorMsg = { link = "Error" },
      FloatBorder = { bg = "none", fg = "#756a60" },
      MsgSeparator = { link = "VertSplit" },

      -- Telescope
      TelescopeBorder = { link = "FloatBorder" },
      TelescopePromptBorder = { link = "FloatBorder" },
      TelescopePreviewBorder = { link = "FloatBorder" },
    },
  },
}
