-- Neovim/Vim color scheme inspired by Dark+ and Light+
-- https://github.com/Mofiqul/vscode.nvim
---@module "vscode"

---@type LazySpec
return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  opts = function()
    local c = require("vscode.colors").get_colors()
    return {
      style = "dark",
      transparent = true,
      italic_comments = false,
      disable_nvimtree_bg = true,
      color_overrides = {},
      group_overrides = {
        ColorColumn = { bg = "Grey7" },
        CurSearch = { link = "IncSearch" },
        CursorLine = { bg = "Grey12" },
        CursorLineNr = { link = "Number" },
        EndOfBuffer = { fg = c.vscGray },
        FloatBorder = { fg = c.vscGray },
        MsgSeparator = { link = "WinSeparator" },
        NormalFloat = { link = "Normal" },
        SpecialChar = { fg = c.vscBlue },
        StatusLine = { bg = "none" },
        TablineFill = { bg = "none" },
        Title = { fg = c.vscYellowOrange },

        Error = { fg = c.vscRed, bold = true },
        WarningMsg = { fg = c.vscYellowOrange, bold = true },

        -- Git
        Added = { fg = c.vscGitAdded },
        Changed = { fg = c.vscYellow },
        Removed = { fg = c.vscRed },

        -- Diff
        DiffAdd = { bg = "#242b16" },
        DiffChange = { bg = "#181818" },
        DiffDelete = { bg = c.vscDiffRedDark, fg = c.vscGitDeleted },
        DiffText = { bg = "#42401f" },

        -- Diagnostics
        DiagnosticVirtualTextError = { bg = c.vscBack, fg = c.vscRed },
        DiagnosticVirtualTextHint = { bg = c.vscBack, fg = c.vscWhite },
        DiagnosticVirtualTextInfo = { bg = c.vscBack, fg = c.vscBlue },
        DiagnosticVirtualTextWarn = { bg = c.vscBack, fg = c.vscYellow },

        -- LSP
        LspCodeLens = { link = "LineNr" },
        LspFloatWinNormal = { link = "NormalFloat" },
        LspInfoBorder = { link = "FloatBorder" },

        ["@lsp.mod.defaultLibrary.lua"] = { link = "@namespace" },

        -- Null-LS
        NullLsInfoBorder = { link = "FloatBorder" },

        -- DAP
        NvimDapVirtualText = { link = "LspCodeLens" },

        -- Treesitter
        ["@string.special.url"] = { fg = c.vscBlue, underline = true },

        -- Snacks
        SnacksPickerBorder = { link = "FloatBorder" },
        SnacksPickerDir = { link = "NonText" },

        -- Neogit
        NeogitBranch = { fg = c.vscYellow },
        NeogitCommitViewHeader = { fg = c.vscBlue, bg = c.vscContext, bold = true },
        NeogitDiffAdditions = { fg = c.vscGitAdded },
        NeogitObjectId = { fg = c.vscBlueGreen },
        NeogitStash = { fg = c.vscViolet },

        -- Hop
        HopCursor = { link = "Cursor" },
        HopNextKey = { fg = c.vscRed, bold = true },
        HopNextKey1 = { fg = c.vscBlue, bold = true },
        HopNextKey2 = { fg = c.vscBlueGreen, bold = true },
        HopPreview = { link = "IncSearch" },
        HopUnmatched = { fg = c.vscContext },
      },
    }
  end,
}
