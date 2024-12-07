-- Define colors for builtin colorscheme: default

---@type config.Highlights
local colors = {
  ColorColumn = { ctermbg = 24, bg = "NvimDarkBlue" },
  Constant = { ctermfg = 217, fg = "NvimLightRed" },
  CursorLineNr = { ctermfg = 222, fg = "NvimLightYellow", bold = true },
  Error = { ctermfg = 217, fg = "NvimLightRed" },
  ErrorMsg = { ctermfg = 217, ctermbg = 9, fg = "NvimLightRed", bg = "NvimDarkRed" },
  FloatBorder = { link = "WinSeparator" },
  Folded = { ctermbg = 234, bg = "NvimDarkGrey2" },
  MsgSeparator = { link = "WinSeparator" },
  Normal = { ctermfg = 253, fg = "NvimLightGrey2" },
  PmenuSel = { ctermbg = 254, ctermfg = 16, bg = "NvimLightGrey2", fg = "Black" },
  Statement = { ctermfg = 177, fg = "Violet" },
  StatusLine = { ctermbg = "none", bg = "none" },
  Title = { link = "Special" },
  Type = { ctermfg = 153, fg = "NvimLightBlue" },
  WinSeparator = { ctermfg = 237, fg = "NvimDarkGrey4" },
  WinBar = { link = "Normal" },
  WinBarNC = { link = "Normal" },
  VertSplit = { link = "WinSeparator" },

  -- Git
  Added = { ctermfg = 157, fg = "NvimLightGreen", bold = true },
  Changed = { ctermfg = 222, fg = "NvimLightYellow", bold = true },
  Removed = { ctermfg = 217, fg = "NvimLightRed", bold = true },

  -- Diff
  DiffAdd = { ctermbg = 236, ctermfg = 40, bg = "NvimDarkGreen" },
  DiffChange = { ctermbg = 236, ctermfg = 75, bg = "NvimDarkBlue" },
  DiffDelete = { ctermbg = 236, ctermfg = 196, fg = "NvimLightRed" },
  DiffText = { ctermbg = 236, bg = "Grey19" },

  -- LSP
  ["@lsp.mod.defaultLibrary.lua"] = { link = "@namespace" },
  ["@lsp.mod.global.lua"] = { ctermfg = 217, fg = "NvimLightRed" },

  -- Treesitter
  ["@string.special.url.comment"] = { ctermfg = 153, fg = "NvimLightBlue", underline = true },
  ["@variable"] = { link = "Identifier" },

  -- Rainbow Delimiters
  RainbowDelimiterBlue = { ctermfg = 153, fg = "NvimLightBlue", nocombine = true },
  RainbowDelimiterCyan = { ctermfg = 123, fg = "NvimLightCyan", nocombine = true },
  RainbowDelimiterGreen = { ctermfg = 157, fg = "NvimLightGreen", nocombine = true },
  RainbowDelimiterOrange = { ctermfg = 214, fg = "Orange", nocombine = true },
  RainbowDelimiterPink = { ctermfg = 209, fg = "Salmon", nocombine = true },
  RainbowDelimiterRed = { ctermfg = 217, fg = "NvimLightRed", nocombine = true },
  RainbowDelimiterViolet = { ctermfg = 211, fg = "PaleVioletRed1", nocombine = true },
  RainbowDelimiterYellow = { ctermfg = 222, fg = "NvimLightYellow", nocombine = true },
}

-- Neovim 0.10+ introduces a new default colorscheme.
-- In older versions, `default` refers to the old scheme, now renamed `vim` in newer versions.
-- Support older versions by loading the appropriate color definitions.
if vim.fn.has("nvim-0.10") == 0 then
  colors = require("after.colors.vim")
end

-- Don't modify Normal if background is set to light mode.
if vim.o.background == "light" then
  colors.Constant = { fg = "NvimDarkRed" }
  colors.Normal = nil
  colors.Statement = { fg = "DarkViolet", bold = true }
end

return colors
