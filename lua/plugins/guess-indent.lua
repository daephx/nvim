-- guess-indent | Automatic indentation style detection for Neovim
-- https://github.com/NMAC427/guess-indent.nvim

return {
  "NMAC427/guess-indent.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "GuessIndent" },
}