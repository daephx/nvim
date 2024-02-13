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
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" } },
      HACK = { icon = "󰈸 ", color = "warning" },
      NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
      PERF = { icon = "󰓅 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      TEST = { icon = "󰂓 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      TODO = { icon = " ", color = "info", alt = { "WIP" } },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    },
    highlight = {
      keyword = "fg", -- "fg", "bg", "wide" or empty.
      after = "", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)(\(.*\))?:]],
      comments_only = true,  -- uses treesitter to match keywords in comments only
      -- list of file types to exclude highlighting
      exclude = { "help", "log" },
    },
    colors = {
      default = { "Include", "#7C3AED" },
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      hint = { "DiagnosticHint", "#10B981" },
      info = { "DiagnosticInfo", "#2563EB" },
      test = { "Include", "#FF00FF" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    },
    search = {
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder!
      -- Match to colon ':', optional parenthesis | KEYWORD(AUTHOR):
      pattern = [[\b(KEYWORDS)(\(.*\))?:]],
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
      desc = "Remove default todo higroup",
      group = vim.api.nvim_create_augroup("Todo#RemoveDefaultHigroup", {}),
      callback = function()
        vim.api.nvim_set_hl(0, "Todo", {})
      end,
    })
  end,
}
