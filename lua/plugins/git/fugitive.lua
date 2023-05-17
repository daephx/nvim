-- vim-fugitive | A Git wrapper so awesome, it should be illegal
-- https://github.com/tpope/vim-fugitive

return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  config = function(_, _)
    -- Open Gdiffsplit in new tab
    vim.api.nvim_create_user_command("GdiffsplitTab", function()
      local git_dir = vim.fn.FugitiveGitDir()
      if vim.fn.empty(git_dir) == 0 then
        vim.cmd(string.format("exe 'tabedit %s'", vim.fn.expand("%")))
        vim.cmd("Gdiffsplit")
        --- Keymaps ---
        local opts = { buffer = 0, remap = true, silent = true }
        vim.keymap.set("n", "q", "<cmd>tabclose<cr>", opts)
      end
    end, {})

    -- Open GcLog in new tab
    vim.api.nvim_create_user_command("GclogTab", function()
      local git_dir = vim.fn.FugitiveGitDir()
      if vim.fn.empty(git_dir) == 0 then
        vim.cmd("tabnew | GcLog")
        --- Keymaps ---
        local opts = { buffer = 0, remap = true, silent = true }
        vim.keymap.set("n", "q", "<cmd>tabclose<cr>", opts)
      end
    end, {})
  end,
}
