-- Mistypes
vim.cmd([[
cnoreabbrev W   w
cnoreabbrev Wq wq
cnoreabbrev Xa xa
cnoreabbrev xA xa
cnoreabbrev XA xa

cnoreabbrev qq 1,$bd!

" Better bufdelete
cnoreabbrev bd bn\|bd#

" Minimal BufDel
" Prevent windows from being removed when deleting buffers
function! BufferDelete()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    \ && &ft != 'dashboard'
      Dashboard | bd#
  else | bn | bd#
  endif
endfunction
cnoreabbrev <silent> bd call BufferDelete()
]])
