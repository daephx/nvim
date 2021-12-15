" File: quickfix.vim
" Description: Configurations for quickfix menus

" Settings
setlocal colorcolumn=
setlocal cursorline
setlocal cursorlineopt=both
setlocal norelativenumber
setlocal signcolumn=


" Mappings
nnoremap <silent> <buffer> q <cmd>cclose<CR>
nnoremap <silent> <buffer> o <CR><C-w>p
