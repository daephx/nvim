-- vscode.nvim | Neovim/Vim color scheme inspired by Dark+ and Light+
-- https://github.com/Mofiqul/vscode.nvim
local vscode_ok, vscode = pcall(require, "vscode")
if not vscode_ok then
  return
end

local c = require("vscode.colors").get_colors()

vim.g.vscode_style = "dark"

vscode.setup({
  transparent = true,
  italic_comments = false,
  disable_nvimtree_bg = true,
  color_overrides = {
    vscFoldBackground = "#242424",
  },
  group_overrides = {
    -- General
    ColorColumn = { bg = "#0f0f0f" },
    CurSearch = { link = "IncSearch" },
    CursorLineNr = { link = "Number" },
    EndOfBuffer = { fg = "#222222" },
    MsgSeparator = { link = "VertSplit" },
    SpecialChar = { fg = c.vscBlue },

    -- Floating Windows
    NormalFloat = { link = "Normal" },
    FloatBorder = { fg = "#5A5A5A", bg = "none" },
    LspFloatWinNormal = { link = "NormalFloat" },
    LspInfoBorder = { link = "FloatBorder" },

    -- Git status
    DiffAdd = { bg = "#212D19", fg = "none" },
    DiffChange = { bg = "#3B3814", fg = "none" },
    DiffDelete = { bg = "none", fg = "indianred" },

    -- Diagnostic
    DiagnosticVirtualTextError = { bg = c.vscBack, fg = c.vscRed },
    DiagnosticVirtualTextWarn = { bg = c.vscBack, fg = c.vscYellow },
    DiagnosticVirtualTextInfo = { bg = c.vscBack, fg = c.vscBlue },
    DiagnosticVirtualTextHint = { bg = c.vscBack, fg = c.vscWhite },

    -- Whichkey
    WhichKeyFloat = { link = "StatusLineNC" },
  },
})
