-- guess-indent.nvim | Automatic indentation style detection
-- https://github.com/NMAC427/guess-indent.nvim
local guess_indent_ok, guess_indent = pcall(require, "guess-indent")
if not guess_indent_ok then
  return
end

guess_indent.setup({
  filetype_exclude = {
    "python",
    "make",
  },
  buftype_exclude = {
    "terminal",
    "fugitive",
    "nowrite",
  },
})
