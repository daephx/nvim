-- EditorConfig plugin for Neovim
-- https://github.com/gpanders/editorconfig.nvim

return {
  "gpanders/editorconfig.nvim",
  event = "BufReadPre",
  dependencies = {
    -- Heuristically set buffer options
    "tpope/vim-sleuth",
  },
}
