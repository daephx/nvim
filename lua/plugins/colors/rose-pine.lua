-- rose-pine | All natural pine, faux fur and a bit of soho vibes for the classy minimalist.
-- https://github.com/rose-pine/neovim
---@module "rose-pine"

---@type LazyPluginSpec
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    enable = {
      terminal = true,
      legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
      migrations = true, -- Handle deprecated options automatically
    },
    styles = {
      bold = false,
      italic = false,
      transparency = true,
    },
    groups = {
      border = "highlight_med",
      link = "iris",
      panel = "surface",

      error = "love",
      hint = "iris",
      info = "foam",
      note = "pine",
      todo = "rose",
      warn = "gold",

      git_add = "foam",
      git_change = "gold",
      git_delete = "love",
      git_dirty = "rose",
      git_ignore = "muted",
      git_merge = "iris",
      git_rename = "pine",
      git_stage = "iris",
      git_text = "rose",
      git_untracked = "subtle",

      h1 = "iris",
      h2 = "foam",
      h3 = "rose",
      h4 = "gold",
      h5 = "pine",
      h6 = "foam",
    },
    ---@type table<string, vim.api.keyset.highlight>
    highlight_groups = {
      CursorLineNr = { fg = "gold" },
      LineNr = { fg = "highlight_med" },
      MatchParen = { bg = "subtle" },
      Pmenu = { bg = "surface" },
      Underlined = { fg = "iris", underline = true },
      WinBar = { bg = "none" },
      WinBarNC = { bg = "none" },

      -- Diff
      DiffAdd = { bg = "#2a383a", inherit = false },
      DiffChange = { bg = "#4a3824", inherit = false },
      DiffDelete = { bg = "#381a22", fg = "love", inherit = false },
      DiffText = { bg = "#2e395c", inherit = false },

      -- Neogit
      NeogitDiffAdd = { link = "DiffAdd" },
      NeogitDiffChange = { link = "DiffChange" },
      NeogitDiffDelete = { link = "DiffDelete" },
      NeogitDiffText = { link = "DiffText" },

      -- Rainbow Delimiters
      RainbowDelimiterBlue = { fg = "foam", nocombine = true },
      RainbowDelimiterCyan = { fg = "foam", nocombine = true },
      RainbowDelimiterGreen = { fg = "iris", nocombine = true },
      RainbowDelimiterOrange = { fg = "gold", nocombine = true },
      RainbowDelimiterPink = { fg = "rose", nocombine = true },
      RainbowDelimiterRed = { fg = "rose", nocombine = true },
      RainbowDelimiterViolet = { fg = "iris", nocombine = true },
      RainbowDelimiterYellow = { fg = "gold", nocombine = true },
    },
  },
}
