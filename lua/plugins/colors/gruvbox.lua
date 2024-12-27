-- Lua port of the most famous vim colorscheme
-- https://github.com/ellisonleao/gruvbox.nvim
---@module "gruvbox"

local terminal = {
  "#32302f",
  "#cc241d",
  "#98971a",
  "#d79921",
  "#458588",
  "#b16286",
  "#689d6a",
  "#a89984",
  "#453e37",
  "#fb4934",
  "#b8bb26",
  "#fabd2f",
  "#83a598",
  "#d3869b",
  "#8ec07c",
  "#ebdbb2",
}

---@type LazyPluginSpec
return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  ---@type GruvboxConfig
  opts = {
    bold = false,
    contrast = "soft", -- can be "hard", "soft" or empty string
    dim_inactive = false,
    inverse = false, -- invert background for search, diffs, statusline and errors
    transparent_mode = true,
    italic = {
      comments = false,
      emphasis = false,
      folds = false,
      operators = false,
      strings = false,
    },
    palette_overrides = {},
    overrides = {
      CursorLineNr = { bg = "none" },
      ErrorMsg = { link = "Error" },
      FloatBorder = { link = "GruvboxGray" },
      MsgSeparator = { link = "WinSeparator" },
      NormalFloat = { link = "Normal" },
      SignColumn = { link = "Normal" },
      VertSplit = { link = "WinSeparator" },
      WinBar = { bg = "none" },
      WinBarNC = { bg = "none" },

      -- Git
      Added = { link = "GruvboxGreen" },
      Changed = { link = "GruvboxBlue" },
      Removed = { link = "GruvboxRed" },

      -- Diff
      DiffAdd = { ctermfg = 142, ctermbg = 235, fg = "none", bg = "#2c2c07" },
      DiffChange = { ctermfg = 208, ctermbg = 235, fg = "none", bg = "#2a3531" },
      DiffDelete = { ctermfg = 203, ctermbg = 235, fg = "#ae3224", bg = "#47140e" },
      DiffText = { ctermfg = 208, ctermbg = 235, fg = "none", bg = "#3a4844" },

      -- Neogit
      NeogitDiffAdd = { fg = "#8fa35c", bg = "#2c2c07" },

      -- Treesitter
      ["@string.special.url"] = { link = "Underlined" },

      -- LSP
      LspReferenceWrite = { fg = "#fe8019", bg = "#3c3836" },

      -- Telescope
      TelescopeBorder = { link = "FloatBorder" },
      TelescopePreviewBorder = { link = "FloatBorder" },
      TelescopePromptBorder = { link = "FloatBorder" },
      TelescopeResultsBorder = { link = "FloatBorder" },
      TelescopeSelection = { link = "CursorLine" },

      -- Dap
      DapUINormal = { link = "Normal" },
      DapUINormalNC = { link = "Normal" },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
      desc = "Enable `transparent_mode` only when background is set to `dark`",
      group = vim.api.nvim_create_augroup("Gruvbox#FixBackground", {}),
      pattern = "gruvbox",
      callback = function()
        local is_dark = vim.o.background == "dark" and true or false
        local gruvbox = package.loaded["gruvbox"]
        if gruvbox ~= nil then
          gruvbox.setup({ transparent_mode = is_dark })
        end
      end,
    })

    local colors = require("config.colors")
    colors.set_hl_autocmd("gruvbox", function()
      if vim.o.background == "dark" then
        -- Apply terminal color overrides
        for i, color in ipairs(terminal) do
          vim.g["terminal_color_" .. i - 1] = color
        end
      end
    end)
  end,
}
