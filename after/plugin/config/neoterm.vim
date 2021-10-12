" File: neoterm.vim
" Desc: Configs for neoterm plugin

" --- Initalization ---

" Prevent this file from loading without plugin
if empty('g:neoterm_loaded') | finish | endif

" Windows - Powershell
if has("win32")
  " Use pwsh if avalible, else use windows powershell
  let g:neoterm_shell = executable('pwsh') ? 'pwsh' : 'powershell'
  let g:neoterm_eof = "\r"
else " Use whatever shell you prefer, default to bash
  let g:neoterm_shell = executable('zsh') ? 'zsh' : 'bash'
endif

" Neoterm Options

let g:neoterm_default_mod = "botright"
let g:neoterm_size = 25
let g:neoterm_autoscroll = 1
let g:neoterm_keep_term_open = 1
let g:neoterm_autoinsert = 1
let g:neoterm_fixedsize = 1

" Functions

" Another method for calling terminal
" prevent certain filestype buffers from splitting.
" such as, Nerdtree, CocExplorer
" function ToggleTerm()
"   if &buftype == 'nofile'
"     echo 'Cannot open terminal here'
"   else
"     silent execute ':Ttoggle botright split'
"   endif
" endfunction

" noremap <silent> <leader>t :call ToggleTerm()<CR>

" Mappings

" Escape terminal buffer via <ESC>
" tnoremap <silent> <Esc> <C-\><C-n>

" Spawn/Toggle Terminal
noremap <silent> <leader>` :Ttoggle<CR>
tnoremap <silent> <leader>` <C-\><C-n>:Ttoggle<CR>
noremap <silent> <F12> :Ttoggle<CR>
tnoremap <silent> <F12> <C-\><C-n>:Ttoggle<CR>

" Allow Ctrl+W to switch window in terminal
tnoremap <silent> <C-w> <C-\><C-n><C-w>

" Press enter for insert mode in terminal
" nnoremap <Enter> :if &buftype = 'terminal' | startinsert | endif

" Automatic insert mode on terminal buf/win enter
" Prevent terminal buffer for holding <Esc> hostage
" Provides compatability with fzf terminal window
augroup TerminalBuffers
  autocmd!
  if has("nvim")
    " Hide terminal from buffer list
    autocmd TermOpen,TermEnter * setlocal nobuflisted
    " Auto enter insert mode for terminal buffers
    " autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
    " Allow escape from terminal and fzfterm
    autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    autocmd FileType fzf tunmap <buffer> <Esc>
  endif
augroup END

" Automatically switch to insert mode when focusing on terminal
" NOTE(daephx): This is having some issue with CocExplorer being opened on TermBufEnter
" autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
