" File: quickfix.vim
" Description: Configurations for quickfix menus

" Settings
setlocal colorcolumn=-1
setlocal cursorline
setlocal cursorlineopt=both
setlocal norelativenumber
setlocal signcolumn=no


" Mappings
nnoremap <silent> <buffer> q <cmd>cclose<CR>
nnoremap <silent> <buffer> o <CR><C-w>p
