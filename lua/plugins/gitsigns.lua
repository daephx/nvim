-- gitsigns.nvim | Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim

---Sets a high sign priority if the signcolumn width is greater than 2.
---@return number?
local priority = function()
  local number = tonumber(vim.o.signcolumn:match("^[^:]+:(%d+)$"))
  local is_nvim_11 = vim.fn.has("nvim-0.11") == 1
  if is_nvim_11 and number and number >= 2 then
    return 1000
  end
end

---@param buffer integer
local on_attach = function(buffer)
  local gitsigns = require("gitsigns")
  local util = require("config.util")
  -- stylua: ignore
  util.register_keymaps({ buffer = buffer }, {
    -- Navigation
    { "n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]h", bang = true })
      else
      ---@diagnostic disable-next-line: param-type-mismatch
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Next hunk" } },

    { "n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[h", bang = true })
      else
      ---@diagnostic disable-next-line: param-type-mismatch
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Previous hunk" } },

    -- Actions
    { "n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" } },
    { "n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" } },
    { "v", "<leader>gr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" } },

    { "n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" } },
    { "n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" } },
    { "v", "<leader>gs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" } },

    { "n", "<leader>gb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" } },

    { "n", "<leader>gP", gitsigns.preview_hunk_inline, { desc = "Preview hunk (inline)" } },
    { "n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" } },

    -- NOTE: Disabled in favor of using diffview.nvim for diffs
    -- { "n", "<leader>gD", function() gitsigns.diffthis("~") end, { desc = "Diff buffer ~" } },
    -- { "n", "<leader>gd", gitsigns.diffthis, { desc = "Diff buffer" } },

    -- Quickfix
    ---@diagnostic disable-next-line: param-type-mismatch
    { "n", "<leader>gQ", function() gitsigns.setqflist("all") end, { desc = "Set quickfix (all)" } },
    { "n", "<leader>gq", gitsigns.setqflist, { desc = "Set quickfix" } },

    -- Toggles
    { "n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" } },
    { "n", "<leader>gtw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" } },

    -- Text object
    { { "o", "x" }, "gih", gitsigns.select_hunk, { desc = "Select hunk" } },
  })
end

---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    sign_priority = priority(),
    on_attach = on_attach,
    attach_to_untracked = true,
    signs_staged_enable = true,
    current_line_blame = true,
    current_line_blame_formatter = "■ <author>, <author_time> - <abbrev_sha>: <summary>",
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "┃" },
      topdelete = { text = "┃" },
      changedelete = { text = "┃" },
      untracked = { text = "┇" },
    },
    signs_staged = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "│" },
      topdelete = { text = "│" },
      changedelete = { text = "│" },
      untracked = { text = "┆" },
    },
  },
}
