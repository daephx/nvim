-- vim-fugitive | A Git wrapper so awesome, it should be illegal
-- https://github.com/tpope/vim-fugitive

---@type LazyPluginSpec
return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  keys = {
    { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Diff current buffer" },
    { "<leader>gg", "<cmd>Gtabedit :<CR>", desc = "Git Status (Fugitive)" },
    { "<leader>gl", "<cmd>GclogTab<CR>", desc = "Git Log" },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "",
      group = vim.api.nvim_create_augroup("FugitiveOptions", {}),
      pattern = { "fugitive" },
      callback = function()
        -- Buffer local options
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline = true
        vim.opt_local.cursorlineopt = "both"
        vim.opt_local.colorcolumn = "0"
        vim.opt_local.signcolumn = "yes:1"
        vim.opt_local.foldmethod = "syntax"
        vim.opt_local.bufhidden = "delete"

        -- Buffer local keymaps
        local opts = { buffer = true, remap = true, silent = true }

        vim.keymap.set("n", "<tab>", "=", opts)
      end,
    })
  end,
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
