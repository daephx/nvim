" Make Vim open help in a vertical split?
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd J | endif
augroup END
