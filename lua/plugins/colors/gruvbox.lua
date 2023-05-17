-- Lua port of the most famous vim colorscheme
-- https://github.com/ellisonleao/gruvbox.nvim

return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  opts = {
    transparent_mode = true,
    contrast = "hard", -- can be "hard", "soft" or empty string
    inverse = false, -- invert background for search, diffs, statuslines and errors
    invert_intend_guides = false,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    bold = false,
    italic = {
      comments = false,
      folds = false,
      operators = false,
      strings = false,
    },
    palette_overrides = {},
    overrides = {
      Normal = { bg = "none" },
      NormalFloat = { bg = "none" },
      CursorLineNr = { bg = "none" },
      ErrorMsg = { bg = "none", fg = "#fb4934" },
      FloatBorder = { bg = "none", fg = "#756a60" },
      MsgSeparator = { link = "VertSplit" },
      SignColumn = { bg = "none" },
      VertSplit = { bg = "none" },

      -- Git status
      -- DiffAdd = { bg = "#b8bb26", fg = "none" },
      -- DiffChange = { bg = "#fabd2f", fg = "none" },
      DiffDelete = { bg = "none", fg = "#fb4934" },
    },
  },
}
