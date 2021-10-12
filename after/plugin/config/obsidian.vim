
function! OpenInObsidianMD(vault)
    execute "silent !open 'obsidian://open?vault=" . a:vault
        \ . "&file=" . expand('%:r') . "'"
endfunction

if exists('g:loaded_vimwiki')
  let s:vault = <Plug>
endif

" Open file in Obsidian vault
command ObsidianMD :call OpenInObsidianMD()
nnoremap <leader>wo :IO<CR>
