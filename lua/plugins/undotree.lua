-- The undo history visualizer for VIM
-- https://github.com/mbbill/undotree

return {
  "mbbill/undotree",
  cmd = { "UndotreeShow", "UndotreeToggle" },
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "Set buffer options for undotree filetype",
      group = vim.api.nvim_create_augroup("UndotreeOptions", {}),
      pattern = { "undotree" },
      callback = function()
        vim.opt_local.list = false
        vim.opt_local.spell = false
        vim.opt_local.number = false
        vim.opt_local.cursorline = true
        vim.opt_local.cursorlineopt = "both"
        vim.opt_local.signcolumn = "no"
      end,
    })
  end,
}
