" Description: File detection for shell script files

augroup detectShFiletype
  autocmd!

  " Common rc files
  " It's preferable that you use a shebang for shell scripts
  autocmd BufNewFile,BufRead .*aliases setlocal ft=sh

  " Environment files
  autocmd BufRead,BufNewFile .env* setfiletype sh

augroup END
