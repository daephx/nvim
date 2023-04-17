-- gruvbox.nvim | Lua port of the most famous vim colorscheme
-- https://github.com/ellisonleao/gruvbox.nvim
local gruvbox_ok, gruvbox = pcall(require, "gruvbox")
if not gruvbox_ok then
  return
end

local M = {}

--- Highlights ---

M.group_overrides = {
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
}

--- Setup ---

gruvbox.setup({
  bold = false,
  italic = {
    comments = false,
    folds = false,
    operators = false,
    strings = false,
  },
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = false, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  transparent_mode = true,
  palette_overrides = {},
  overrides = M.group_overrides,
})

return M
