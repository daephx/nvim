-- todo-comments.nvim | Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim

---@type LazySpec
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = {
    "TodoLocList",
    "TodoQuickFix",
    "TodoTrouble",
  },
  -- stylua: ignore
  keys = {
    { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
  },
  ---@module "todo-comments"
  ---@type TodoOptions
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
      pattern = ".*<((KEYWORDS)%(\\(.{-1,}\\))?):",
      comments_only = true, -- uses treesitter to match keywords in comments only
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
      pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
    },
  },
  init = function()
    -- Set default highlights
    local colors = require("config.colors")
    colors.set_hl_autocmd(nil, {
      Todo = {},
      ["@comment.todo"] = {},
      ["@comment.hint"] = {},
      ["@comment.note"] = {},
      ["@comment.warning"] = {},
      ["@comment.error"] = {},
    })
  end,
}
