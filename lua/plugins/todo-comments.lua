-- todo-comments.nvim | Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local todo = require("todo-comments")
    return {
      { "]t", todo.jump_next, desc = "Next todo comment" },
      { "[t", todo.jump_prev, desc = "Previous todo comment" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Search Todo comments" },
    }
  end,
  opts = {
    signs = true, -- show icons in the signs column
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" },
      },
      TODO = { icon = " ", color = "info", alt = { "WIP" } },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
    },
    highlight = {
      keyword = "wide", -- "fg", "bg", "wide" or empty.
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)(\(.*\))?:]],
      comments_only = true,
      exclude = { -- list of file types to exclude highlighting
        "help",
        "log",
        "vim",
      },
    },
    search = {
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder!
      -- Match to colon ':', optional parenthesis | KEYWORD(AUTHOR):
      pattern = [[\b(KEYWORDS)(\(.*\))?:]],
    },
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)

    local group = vim.api.nvim_create_augroup("TodoCommentHooks", {})
    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
      desc = "Remove default todo higroup",
      group = group,
      callback = function()
        vim.api.nvim_set_hl(0, "Todo", {})
      end,
    })
  end,
}
