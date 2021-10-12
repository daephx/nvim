" Determine of running in Neovide GUI
" https://vi.stackexchange.com/a/27791
let g:is_neovide = exists("g:neovide")

" Prevent execution if not compatible!
if !g:is_neovide | finish | endif

redraw | echom "Neovide detected: sourcing configuration..."

" Set window opacity for neovide
let g:neovide_transparency=0.9

" super key, command key or windows key) is handled
" NOTE(daephx): I would use this but I don't want to break mental compatability
"               with the more general, terminal interface where super is restricted.
let g:neovide_input_use_logo=v:true

" Remember Previous Window Size
let neovide_remember_window_size = v:true

" Neovide maximised in Windows!
" https://github.com/neovide/neovide/issues/356#issuecomment-921431879
function Neovide_fullscreen()
    if g:neovide_fullscreen == v:true
        let g:neovide_fullscreen=v:false
    else
        let g:neovide_fullscreen=v:true
    endif
endfunction

map <F11> :call Neovide_fullscreen()<CR>
