" File: experimental.vim
" Description: Load experimental configurations
" These can often be unstable and are purely for testing
" new mappings/settings while keeping the base initrc clean.
"
" Enable experimental mode by setting the global variable:
"
"   let g:experimental_on = 1

" --- Initialization ---

if exists('g:experimental_on')
      \ && g:experimental_on == 1
  finish
endif

" --- Settings ---

" nmap <C-n> :bn<CR> " Next buffer in list
" nmap <C-p> :bp<CR>  " Previous buffer in list
" nmap <C-#> :b#<CR>  " Previous buffer you were in
" nmap <C-4> :b#<CR>  " Previous buffer you were in

" Remap arrow keys for navigation
" TODO(daephx): Breaks normal-mode arrow navigation
" nnoremap <Up>        <C-W>k
" nnoremap <Down>      <C-W>j
" nnoremap <Left>      <C-W>h
" nnoremap <Right>     <C-W>l

" ---
" Alt-Arrows for moving lines
" TODO(deaphx): Consider, move selection
" nmap <silent> <A-Up>    :'<,'>m-2<CR>
" nmap <silent> <A-Down>  :'<,'>m+2<CR>

" !! Testing !!


" Add/Remove <space> depending on setting, default `set selection=inclusive`
" If selection is set to exclusive, add space to the end.
" vnoremap <A-Right> lholhxp`[1v<Space>
nnoremap <A-Right> viwm`w``xwzvP`[1v<Space>
nnoremap <A-Left> viwm`bb``xbzvP`[1v<Space>
nnoremap <A-Down> viwjkxjzvP`[1v<Space>
nnoremap <A-Up> viwkjxkzvP`[1v<Space>

map <Silent> <C-PageUp>   :bn<CR>
map <Silent> <C-PageDown> :bp<CR>
" imap <a-s-Up> :<,''>bn<CR>
" imap <a-s-PageDown> :bp<CR>

" * Standard system copy/cut/paste *
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" Alternatively, set 'mswin' runtime
" source $VIMRUNTIME/mswin.vim
" behave mswin

" Cursor configs

fun! UpdateTermCursor()

  " Cursor in terminal:
  " Link: https://vim.fandom.com/wiki/Configuring_the_cursor
  " 0 -> blinking block not working in wsl
  " 1 -> blinking block
  " 2 -> solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar

  if &term =~ "xterm\\|rxvt"
    fun! s:cologet(gr)
      let cc = execute('hi ' . a:gr)
      let color = matchstr(cc, 'guifg=\zs[^ ]*')
      if color == 'bg'
        let color = matchstr(cc, 'guibg=\zs[^ ]*')
      endif
      if color == ''
        let color = matchstr(cc, 'ctermfg=\zs[^ ]*')
      endif
      if color[0] == '#'
        let color = 'rgb:' . substitute(color[1:-1], '..', '\0\/', 'g')[0:-2]
      endif
      return color
    endfun
    let cur = s:cologet('Cursor')
    " You can change group, for example CursorLineNr, Special, NonText etc.
    let curb = s:cologet('Type')
    let &t_SI="\<Esc>[5 q\<Esc>]12;" . curb . "\x7"
    let &t_EI="\<Esc>[1 q\<Esc>]12;" . cur . "\x7"
    " Redraw
    :call feedkeys("i\<C-O>:stopinsert\<CR>")
    " silent! exe ':redraw!'
    " :call feedkeys("i\<Esc>l")
    " Restore cursor to I when leaving vim
    augroup TermCursorLeave
      autocmd!
      autocmd VimLeave * silent !echo -ne "\e[5 q"
    augroup END
    augroup windows_term
      autocmd!
      autocmd VimEnter * silent !echo -ne "\e[1 q"
      autocmd VimLeave * silent !echo -ne "\e[5 q"
    augroup END
  endif
endfun


if &term =~ '^xterm'
  " enter vim
  autocmd VimEnter * silent !echo -ne "\e[3 q"
  " otherwise
  let &t_EI .= "\<Esc>[3 q"
  " insert mode
  let &t_SI .= "\<Esc>[5 q"
  " 1 or 0 -> blinking block
  " 2 -> solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
  " leave vim

  let &t_SI.="\e[5 q"
  let &t_SR.="\e[4 q"
  let &t_EI.="\e[1 q"

  autocmd VimLeave * silent !echo -ne "\e[5 q"
endif

if &term == 'win32'
  let &t_ti.=" \e[1 q"
  let &t_SI.=" \e[5 q-- INSERT --"
  let &t_EI.=" \e[1 q"
  let &t_te.=" \e[0 q"
else
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

" highlight Cursor guifg=White guibg=Gray
" highlight iCursor guifg=white guibg=steelblue
" highlight nCursor guifg=Black guibg=Green
" highlight nCursor ctermfg=Black ctermbg=DarkGreen
" set guicursor=n-v-c:block-Cursor
" set guicursor+=i:ver100-iCursor
" set guicursor+=n-v-c:blinkon0
" set guicursor+=i:blinkwait10


" Restore cursor when leaving vim -- Windows Powershell
autocmd VimLeave * silent !echo -ne "\e[5 q"

" Command for writing file and then source it
cnoreabbrev ws :w \| so %           " Write to file and source it
nnoremap \n :echom 'Hardy Harr'<CR> " Testing the above mapping


" Alternative buffer mapping
nnoremap \d :bp<cr>:bd #<cr>

" Easy buffer switching with fzf
nnoremap <Leader><Tab> :bu<CR>

" Easy buffer switching
" FIXME(daephx): Using <tab> is not favorable
" nnoremap <silent> <Tab> :bn<CR>
" nnoremap <silent> <S-Tab> :bp<CR>
" nnoremap <Leader><Tab> :b#<CR>



" Command abbreviations
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')
call SetupCommandAbbrs('ce', 'CocCommand explorer')
" autocmd FileType json syntax match Comment +\/\/.\+$+


" if you want to keep transparent background after changing the colorscheme:
" au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red
au ColorScheme * hi Normal ctermbg=none guibg=none


" NOTE(daephx): Remapping forward-slash
" Weirdly, You have to specify it with an underscore?
" nnoremap <C-_> :echo "Bossboss"<CR>


" Powershell as default 'shell'
silent echo "--- Test Configurations Loaded ---"
silent echo "These settings are potentially unstable."
