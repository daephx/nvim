" File: log.vim
" Description: Detecting generic log format
" This ensures that file filetype is properly set
" that way you can use the &filetype to set syntax

augroup logfile_au
  autocmd!
  " Match general logfiles with '.log' extension
  autocmd BufNewFile,BufRead *.log setlocal filetype=log
  " Match files named 'log' that have NO extension
  autocmd BufNewFile,BufRead ^(log[^.]+)$ setlocal filetype=log

  autocmd FileType log
        \ setlocal readonly
        \ setlocal noedcompatible
        \ setlocal colorcolumn=0
        \ setlocal norelativenumber

augroup END
