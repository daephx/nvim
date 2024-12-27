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
      StatusLine = { bg = "none" },
      Underlined = { fg = "iris", underline = true },
      VertSplit = { link = "WinSeparator" },
      WinBar = { bg = "none", inherit = false },
      WinBarNC = { bg = "none", inherit = false },

      -- Diff
      DiffAdd = { fg = "none", bg = "#2a383a", inherit = false },
      DiffChange = { fg = "none", bg = "#4a3824", inherit = false },
      DiffDelete = { fg = "love", bg = "#421e28", inherit = false },
      DiffText = { fg = "none", bg = "#2e395c", inherit = false },

      -- Git
      Added = { fg = "foam", bg = "none" },
      Changed = { fg = "gold", bg = "none" },
      Removed = { fg = "love", bg = "none" },

      -- Neogit
      NeogitActiveItem = { fg = "gold", bg = "highlight_med" },
      NeogitDiffAdditions = { link = "Added", inherit = false },
      NeogitGraphAuthor = { fg = "leaf" },

      NeogitDiffAdd = { fg = "foam", bg = "#2a383a", inherit = false },
      NeogitDiffChange = { fg = "gold", bg = "#4a3824", inherit = false },
      NeogitDiffDelete = { fg = "love", bg = "#421e28", inherit = false },
      NeogitDiffText = { fg = "none", bg = "#2e395c", inherit = false },

      -- LSP
      ["@string.special.url"] = { fg = "link", underline = true },

      -- DAP
      DapStoppedLine = { bg = "#5c482c" },
    },
  },
}
