" File: NoNuRelativeInserte.vim
" Description:
" Automatically disable relativenumber settings
" when entering insert mode.

" Disable relative numbers in insert mode
augroup NoNuRelativeInsert_au
  autocmd!
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END
