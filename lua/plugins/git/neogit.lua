-- Neogit | magit for Neovim
-- https://github.com/TimUntersberger/neogit

return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  keys = {
    { "<leader>gG", "<cmd>Neogit<CR>", desc = "Git Status (Neogit)" },
  },
  dependencies = {
    -- Collection of useful lua functions
    { "nvim-lua/plenary.nvim" },
    -- Easily cycling through diffs
    { "sindrets/diffview.nvim" },
  },
  opts = {
    kind = "tab",
    disable_context_highlighting = true,
    integrations = {
      diffview = true,
      telescope = true,
    },
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
  end,
}
