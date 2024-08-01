-- neovim-ayu | Ayu theme for Neovim
-- https://github.com/Shatur/neovim-ayu

---@type LazyPluginSpec
return {
  "Shatur/neovim-ayu",
  name = "ayu",
  lazy = false,
  priority = 1000,
  opts = function()
    local c = require("ayu.colors")
    c.generate(false) -- False means: don't use mirage hl
    return {
      overrides = {
        -- General
        Normal = { bg = "none" },
        NormalFloat = { link = "Normal" },
        -- ColorColumn = { bg = "SteelBlue" },
        Comment = { fg = c.comment },
        MsgSeparator = { link = "VertSplit" },
        SignColumn = { bg = "none" },
        SpellBad = { fg = "#ff3333" },
        VertSplit = { bg = "none", fg = c.guide_normal },
        WinSeparator = { link = "VertSplit" },

        -- Treesitter
        ["@text.url"] = { fg = "#59c2ff" },

        -- Dashboard
        DashboardHeader = { fg = c.entity },
        DashboardDesc = { fg = c.accent },
        DashboardFooter = { fg = c.entity, italic = true },
        DashboardIcon = { fg = c.accent },
        DashboardKey = { fg = c.comment },
        DashboardShortCut = { fg = c.markup },

        -- Telescope
        TelescopePreviewBorder = { fg = c.comment },

        -- Which-Key
        WhichKeyFloat = { bg = "NONE" },
      },
    }
  end,
}
