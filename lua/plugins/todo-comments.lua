-- todo-comments.nvim | Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- Collection of useful lua functions
    { "nvim-lua/plenary.nvim" },
  },
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Search Todo comments" },
  },
  opts = {
    signs = true, -- show icons in the signs column
    sign_priority = 8,
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" } },
      HACK = { icon = " ", color = "warning" },
      NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
      PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      TODO = { icon = " ", color = "info", alt = { "WIP" } },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    },
    highlight = {
      keyword = "fg", -- "fg", "bg", "wide" or empty.
      after = "", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)(\(.*\))?:]],
      comments_only = true,
      -- list of file types to exclude highlighting
      exclude = { "help", "log" },
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
