-- nvim-treesitter | Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter

---Set default highlights for rainbow-delimiters
---NOTE: Prevents errors when switching colorschemes which don't have these highlights set.
local init_default_highlights = function()
  local colors = require("config.colors")
  colors.set_hl_autocmd(nil, {
    RainbowDelimiterBlue = { ctermfg = 4, fg = "NvimLightBlue", default = true },
    RainbowDelimiterCyan = { ctermfg = 6, fg = "NvimLightCyan", default = true },
    RainbowDelimiterGreen = { ctermfg = 2, fg = "NvimLightGreen", default = true },
    RainbowDelimiterOrange = { ctermfg = 221, fg = "LightGoldenrod2", default = true },
    RainbowDelimiterPink = { ctermfg = 210, fg = "LightCoral", nocombine = true },
    RainbowDelimiterRed = { ctermfg = 1, fg = "NvimLightRed", default = true },
    RainbowDelimiterViolet = { ctermfg = 177, fg = "NvimLightMagenta", default = true },
    RainbowDelimiterYellow = { ctermfg = 3, fg = "NvimLightYellow", default = true },
  })
end

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdateSync", "TSUpdate" },
  event = { "BufReadPost", "BufNewFile" },
  cond = not vim.g.vscode,
  dependencies = {
    -- Treesitter auto html tags
    { "windwp/nvim-ts-autotag" },
    -- set commentstring based on the cursor location
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    -- Syntax aware text-objects, select, move, swap, etc
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- Treesitter playground integrated into Neovim
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    -- Rainbow delimiters for Neovim with Tree-sitter
    { "hiphish/rainbow-delimiters.nvim", init = init_default_highlights },
    -- Alternative to context.vim using nvim-treesitter
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = { max_lines = 1 },
      init = function()
        local colors = require("config.colors")
        colors.set_hl_autocmd(nil, {
          TreesitterContext = { link = "Normal" },
          TreesitterContextLineNumber = { link = "Normal" },
        })
      end,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  opts = {
    disable = function(_lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    ensure_installed = {
      "bash",
      "c",
      "comment",
      "editorconfig",
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
    autotag = { enable = true },
    highlight = { enable = true },
    indent = {
      enable = true,
      disable = { "yaml" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
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
  },
}
