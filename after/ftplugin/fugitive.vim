" Settings
setlocal colorcolumn=
setlocal cursorline
setlocal cursorlineopt=both
setlocal foldmethod=syntax
setlocal nonumber
setlocal norelativenumber

" Autocmds
augroup fugitive_au
  autocmd!
  autocmd User FugitiveIndex nmap <buffer> dt :Gtabedit <Plug><cfile><Bar>Gdiffsplit<CR>
  autocmd User FugitiveIndex nmap <buffer> <tab> =
  autocmd User FugitiveIndex nmap <buffer> q gq<CR>
augroup END
