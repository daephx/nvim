-- indent-blankline.nvim | Indent guides for Neovim
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufRead", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
      highlight = "LineNr",
    },
    scope = {
      show_start = true,
      show_end = false,
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
      include = {
        node_type = {
          go = { "import_declaration" },
          lua = { "return_statement", "table_constructor" },
        },
      },
    },
    exclude = {
      filetypes = {
        "dashboard",
        "dbui",
        "floaterm",
        "fugitive",
        "log",
        "neogit",
        "undotree",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
