-- kanagawa.nvim | dark colorscheme inspired by famous painting of Katsushika Hokusai
-- https://github.com/rebelot/kanagawa.nvim
---@module "kanagawa"

---@type LazySpec
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  ---@type KanagawaConfig
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
            bg_gutter = "none",
          },
        },
      },
    },
    -- Add/Modify highlights
    overrides = function(colors)
      local theme = colors.theme
      return {
        CursorLine = { bg = theme.ui.bg_dim },
        FloatBorder = { bg = "none" },
        MsgSeparator = { link = "WinSeparator" },
        NormalFloat = { bg = "none" },
        Title = { bg = "none", fg = theme.syn.special1, bold = true },
        WinSeparator = { fg = theme.ui.bg_p1, bg = "none" },

        -- Search
        CurSearch = { bg = theme.ui.bg_search, fg = "black", bold = true },
        IncSearch = { bg = theme.diag.warning, fg = "black", bold = true },
        Search = { bg = theme.ui.bg_search, fg = "black" },

        -- Pmenu
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        -- Treesitter
        ["@string.special.url.comment"] = { fg = colors.palette.springBlue, underline = true },

        -- Rainbow Delimiters
        RainbowDelimiterBlue = { fg = colors.palette.springBlue, nocombine = true },
        RainbowDelimiterCyan = { fg = colors.palette.waveAqua1, nocombine = true },
        RainbowDelimiterGreen = { fg = colors.palette.springGreen, nocombine = true },
        RainbowDelimiterOrange = { fg = colors.palette.surimiOrange, nocombine = true },
        RainbowDelimiterPink = { fg = colors.palette.sakuraPink, nocombine = true },
        RainbowDelimiterRed = { fg = colors.palette.peachRed, nocombine = true },
        RainbowDelimiterViolet = { fg = colors.palette.oniViolet, nocombine = true },
        RainbowDelimiterYellow = { fg = colors.palette.carpYellow, nocombine = true },

        -- Telescope
        TelescopeBorder = { ctermbg = "none", ctermfg = 240, bg = "none", fg = theme.ui.bg_p2 },
        TelescopeTitle = { link = "Title" },

        -- WhichKey
        WhichkeyTitle = { link = "Title" },
      }
    end,
  },
}
