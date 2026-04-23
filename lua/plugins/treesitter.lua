-- nvim-treesitter | Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter

---@type LazySpec
return {
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    cond = not vim.g.vscode,
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts)
      -- Ensure default parsers are installed
      ts.install({
        "bash",
        "c",
        "comment",
        "editorconfig",
        "gitignore",
        "json",
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
      })
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Automatically install parser when opening supported filetypes",
        callback = function(event)
          local ft = event.match
          local lang = vim.treesitter.language.get_lang(ft) or ft
          local available = ts.get_available()
          local installed = ts.get_installed()
          if vim.list_contains(available, lang) then
            if not vim.list_contains(installed, lang) then
              ts.install(lang)
            end
            pcall(vim.treesitter.start, event.buf, lang)
          end
        end,
      })
    end,
    ---@type TSConfig?
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
      disable = function(_lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
  },
  -- Treesitter auto html tags
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  -- set commentstring based on the cursor location
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
  },
  -- Syntax aware text-objects, select, move, swap, etc
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufNewFile", "BufReadPost" },
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugin.
      vim.g.no_plugin_maps = true
    end,
    opts = {
      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
      select = {
        -- Automatically jump forward to text-obj, similar to targets.vim
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v", -- char-wise
          ["@function.outer"] = "V", -- line-wise
          ["@class.outer"] = "<c-v>", -- block-wise
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)
      local move = require("nvim-treesitter-textobjects.move")
      local select = require("nvim-treesitter-textobjects.select")
      local utils = require("config.util")
      -- stylua: ignore
      utils.register_keymaps({}, {
        -- You can use the capture groups defined in `textobjects.scm`
        { { "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end },
        { { "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end },
        { { "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end },
        { { "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end },
        -- You can also use captures from other query groups like `locals.scm`
        { { "x", "o" }, "as", function() select.select_textobject("@local.scope", "locals") end },

        -- You can use the capture groups defined in `textobjects.scm`
        { { "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end },
        { { "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end },
        -- You can also pass a list to group multiple queries.
        { { "n", "x", "o" }, "]o", function() move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects") end },

        -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
        { { "n", "x", "o" }, "]s", function() move.goto_next_start("@local.scope", "locals") end },
        { { "n", "x", "o" }, "]z", function() move.goto_next_start("@fold", "folds") end },

        { { "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end },
        { { "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer", "textobjects") end },

        { { "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end },
        { { "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end },

        { { "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end },
        { { "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer", "textobjects") end },

        -- Go to either the start or the end, whichever is closer. Use if you want more granular movements.
        { { "n", "x", "o" }, "]c", function() move.goto_next("@conditional.outer", "textobjects") end },
        { { "n", "x", "o" }, "[c", function() move.goto_previous("@conditional.outer", "textobjects") end },
      })
    end,
  },
  -- Rainbow delimiters for Neovim with Tree-sitter
  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    ---Set default highlights for rainbow-delimiters
    ---NOTE: Prevents errors when switching colorschemes which don't have these highlights set.
    init = function()
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
    end,
  },
  -- Alternative to context.vim using nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    opts = { max_lines = 1 },
    init = function()
      local colors = require("config.colors")
      colors.set_hl_autocmd(nil, {
        TreesitterContext = { link = "Normal", force = true },
        TreesitterContextLineNumber = { link = "DiagnosticSignHint", force = true },
      })
    end,
  },
}
