-- gitsigns.nvim | Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim

---@type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    attach_to_untracked = true,
    signs_staged_enable = false,
    current_line_blame = true,
    current_line_blame_formatter = "■ <author>, <author_time> - <abbrev_sha>: <summary>",
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▎" },
      topdelete = { text = "▎" },
      changedelete = { text = "▎" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▎" },
      topdelete = { text = "▎" },
      changedelete = { text = "▎" },
      untracked = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]h", function()
        if vim.wo.diff then
          return "]h"
        end
        vim.schedule(function()
          gitsigns.nav_hunk("next")
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next hunk" })

      map("n", "[h", function()
        if vim.wo.diff then
          return "[h"
        end
        vim.schedule(function()
          gitsigns.nav_hunk("prev")
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous hunk" })

      -- Actions
      map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
      map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
      map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "stage buffer" })
      map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>gb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame line" })
      map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
      -- map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff buffer" })
      -- map("n", "<leader>gD", function()
      --   gitsigns.diffthis("~")
      -- end, { desc = "Diffthis ~" })
      map("n", "<leader>gtd", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
    end,
  },
}
