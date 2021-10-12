" File: InspectRuntime.vim
" Description:
" function that creates a list of the current runtime paths.

" Output runtime dirs to buffer
function! InspectRuntime#run()
  let l:runtime = split(&rtp, ",")
  redir @r
  cexpr join(l:runtime, "\n")
  redir END
  botright new
  put r
  set buftype=quickfix
  setlocal nopaste
  setlocal nomodifiable
  copen
endfunction
