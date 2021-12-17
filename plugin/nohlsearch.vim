" Cleaner method of disabling highlighted text after a search when it is no longer need
" From: https://github.com/romainl/vim-cool/issues/9

noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

fu! HlSearch()
  let s:pos = match(getline('.'), @/, col('.') - 1) + 1
  if s:pos != col('.')
    call StopHL()
  endif
endfu

fu! StopHL()
  if !v:hlsearch || mode() isnot 'n'
    return
  else
    sil call feedkeys("\<Plug>(StopHL)", 'm')
  endif
endfu

augroup SearchHighlight
  au!
  au CursorMoved * call HlSearch()
  au InsertEnter * call StopHL()
augroup end
