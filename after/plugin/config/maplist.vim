" Search Mappings / Key bindings
function! s:ShowMapList()
  let old_reg = getreg("a")                 " save the current content of register a
  let old_reg_type = getregtype("a")        " save the type of the register as well
try
  redir @a                                  " redirect output to register a
  silent map | call feedkeys("\<CR>")       " Get all key mappings silently 
  redir END                                 " end output redirection
  vnew Mappings.txt                         " new buffer in vertical window
  put a                                     " put content of register
  %!sort -k1.4,1.4                          " Sort 4th column, which is the key(s)
finally                                     " Execute even if exception is raised
  call setreg("a", old_reg, old_reg_type)   " restore register a
endtry
endfunction
com! ShowMaps call s:ShowMaps()             " Enable :ShowMaps to call the function

nnoremap \m :ShowMapList<CR>                " Map keys to call the function
