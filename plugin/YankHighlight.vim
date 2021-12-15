" Display highlight for a short moment when yanking text
" FIX: YankHighlight requires lua api method. Apply nvim check.
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
