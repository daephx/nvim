" Configuration for VimWiki

" Prevent loading if not applicable
if empty('g:loaded_vimwiki')
  finish
endif


function! VimwikiLinkHandler(link)
  if a:link =~ '\.\(pdf\|jpg\|jpeg\|png\|gif\)$'
    call vimwiki#base#open_link(':e ', 'file:'.a:link)
    return 1
  endif
  return 0
endfunction
