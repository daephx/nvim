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

  " Fugitive status index
  autocmd User FugitiveIndex nmap <buffer> <tab> =
  autocmd User FugitiveIndex nmap <buffer> q gq<CR>

  " Commands applied to fugitive git commit log
  autocmd BufReadPost *
        \ if &ft == 'git'
        \ | nmap <buffer> q tabclose
        \ | endif

augroup END
