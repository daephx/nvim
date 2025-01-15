-- Neovim/Vim color scheme inspired by Dark+ and Light+
-- https://github.com/Mofiqul/vscode.nvim
---@module "vscode"

local terminal = {
  "#000000",
  "#CD3131",
  "#0DBC79",
  "#E5E510",
  "#2472C8",
  "#BC3FBC",
  "#11A8CD",
  "#E5E5E5",
  "#484848",
  "#F14C4C",
  "#23D18B",
  "#F5F543",
  "#3B8EEA",
  "#D670D6",
  "#29B8DB",
  "#E5E5E5",
}

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
        EndOfBuffer = { fg = "Grey35" },
        FloatBorder = { fg = "Grey35", bg = "none" },
        MsgSeparator = { link = "WinSeparator" },
        NormalFloat = { link = "Normal" },
        SpecialChar = { fg = c.vscBlue },
        StatusLine = { bg = "none" },
        Tabline = { bg = "none" },
        TablineFill = { bg = "none" },
        Title = { link = "Special" },
        WarningMsg = { fg = c.vscYellowOrange, bold = true },

        -- Git
        Added = { fg = c.vscGitAdded },
        Changed = { fg = c.vscDiffRedDark },
        Removed = { fg = c.vscRed },

        -- Diff
        DiffAdd = { bg = "#242b16" },
        DiffChange = { bg = "#181818" },
        DiffDelete = { bg = c.vscDiffRedDark, fg = c.vscGitDeleted },
        DiffText = { bg = "#42401f" },

        -- Diagnostics
        DiagnosticVirtualTextError = { bg = c.vscBack, fg = c.vscRed },
        DiagnosticVirtualTextWarn = { bg = c.vscBack, fg = c.vscYellow },
        DiagnosticVirtualTextInfo = { bg = c.vscBack, fg = c.vscBlue },
        DiagnosticVirtualTextHint = { bg = c.vscBack, fg = c.vscWhite },

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
        ["@string.special.url"] = { fg = c.vscBlue },

        -- Rainbow Delimiters
        RainbowDelimiterBlue = { fg = c.vscBlue, nocombine = true },
        RainbowDelimiterCyan = { fg = c.vscBlueGreen, nocombine = true },
        RainbowDelimiterGreen = { fg = c.vscGreen, nocombine = true },
        RainbowDelimiterOrange = { fg = c.vscOrange, nocombine = true },
        RainbowDelimiterPink = { fg = c.vscPink, nocombine = true },
        RainbowDelimiterRed = { fg = c.vscRed, nocombine = true },
        RainbowDelimiterViolet = { fg = c.vscViolet, nocombine = true },
        RainbowDelimiterYellow = { fg = c.vscYellow, nocombine = true },

        -- Dashboard
        DashboardKey = { fg = c.vscGray },

        -- Telescope
        TelescopePromptPrefix = { fg = c.vscBlue },
        TelescopeSelection = { bg = c.vscSelection },
        TelescopeSelectionCaret = { bg = c.vscSelection, fg = c.vscYellow },

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
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      desc = "Replace terminal colors for colorscheme: vscode",
      group = vim.api.nvim_create_augroup("ColorScheme#VscodeTerminal", { clear = true }),
      pattern = "vscode",
      callback = function()
        for i, color in ipairs(terminal) do
          vim.g["terminal_color_" .. i - 1] = color
        end
      end,
    })
  end,
}
