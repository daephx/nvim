" Description: File detection for shellscript files

augroup detectShFiletype
  autocmd!

  " Common rc files
  " It's preferable that you use a shebang for shellscripts
  autocmd BufNewFile,BufRead .*aliases setlocal ft=sh

  " Environment files
  autocmd BufRead,BufNewFile .env* setfiletype sh

augroup END
