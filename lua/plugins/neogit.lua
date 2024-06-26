-- Neogit | magit for Neovim
-- https://github.com/TimUntersberger/neogit

---@type LazyPluginSpec
return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  dependencies = {
    -- Collection of useful lua functions
    { "nvim-lua/plenary.nvim" },
    -- Easily cycling through diffs
    { "sindrets/diffview.nvim" },
  },
  keys = {
    { "<leader>gG", "<cmd>Neogit<CR>", desc = "Git Status (Neogit)" },
  },
  opts = {
    kind = "tab",
    disable_context_highlighting = true,
    integrations = {
      diffview = true,
      telescope = true,
    },
    popup = { kind = "split" },
    commit_popup = { kind = "split_above" },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Local options to apply to neogit filetypes",
      group = vim.api.nvim_create_augroup("NeogitBufferOptions", {}),
      pattern = "Neogit*",
      callback = function()
        vim.opt_local.colorcolumn = "0"
        vim.opt_local.spell = false
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Prevent status buffers from over-scrolling",
      group = vim.api.nvim_create_augroup("NeogitStatusOptions", {}),
      pattern = { "NeogitPopup", "NeogitStatus" },
      callback = function()
        vim.opt_local.scrolloff = 999
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      desc = "Close Neogit after pushing to remote repository",
      group = vim.api.nvim_create_augroup("NeogitPushOptions", {}),
      pattern = "NeogitPushComplete",
      callback = function()
        require("neogit").close()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Set filetype back to gitcommit for NeogitCommitMessage buffer",
      group = vim.api.nvim_create_augroup("NeogitCommitMessageOptions", {}),
      pattern = "NeogitCommitMessage",
      command = "silent! set filetype=gitcommit",
    })
  end,
}
