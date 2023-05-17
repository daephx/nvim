-- The undo history visualizer for VIM
-- https://github.com/mbbill/undotree

return {
  "mbbill/undotree",
  cmd = { "UndotreeShow", "UndotreeToggle" },
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
  },
}
