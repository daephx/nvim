-- nvim-treesitter | Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter
local treesitter_ok, _ = require("nvim-treesitter")
if not treesitter_ok then
  return
end

local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "gitignore",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
  },
  ignore_install = {},
  auto_install = true,
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
    disable = { "python", "yaml" },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 2000,
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})
