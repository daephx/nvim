"     _   __                _
"    / | / /__  ____ _   __(_)___ ___
"   /  |/ / _ \/ __ \ | / / / __ `__ \
"  / /|  /  __/ /_/ / |/ / / / / / / /
" /_/ |_/\___/\____/|___/_/_/ /_/ /_/
"
" File: init.vim
" Author: daephx
" Description: Personal configuration files for NeoVim!
" These settings are designed to fit my preferences/workflow,
" feel free to take what you like from them, no worries.
" Just don't copy them wholesale, figure out what works for you!


" --- Initialization ---

" Determine users vim / nvim runtime path
" Be sure that the first entry in this list is where your vim configs live
" ie: `~/.vim` or `~/.config/nvim`, Otherwise this won't work.
if !exists('$MYRUNTIME')
  let $MYRUNTIME = split(&runtimepath, ',')[0]
endif

" Enable experimental configs
" Located in plugins/experimental.vim
let g:experimental_on = 0


" --- Plugins ---

" Here I am just sourcing the file containing
" my vim-plug configurations.


" --- Mappings ---

" Key bindings that should always be available
" These bindings should have no dependencies!

" keys to call the function Leader key preference
" nnoremap <space> <nop>
let g:mapleader = "\<space>"
let g:localleader = "\\"

" Disable Ex mode
nnoremap <silent>Q <nop>

" TODO: Has some issue with immutable buffers and quickfix,
" perhaps check if the buffer is writable/has a path

" Write/Close buffer, keep window
" nnoremap <leader>q :up\|b#\|bd#<CR>

" Update file only if changes
nnoremap <leader>w :up<CR>

" Better <tab> indentation
inoremap <silent> <S-Tab> <C-d>
vnoremap <silent> <Tab>   >gv
vnoremap <silent> <S-Tab> <gv

" Substitute selection
" Overwrite text with last yanked
" vnoremap S "_d"0P

" Black-hole <Delete> key
" Makes the delete key never yank
nnoremap <Del> "_x
vnoremap <Del> "_x

" Paste last yank, ignore delete
" Paste before/after cursor respectively
nmap <localleader>p "0p
nmap <localleader>P "0P

" This can be a little annoying in select circumstances
" Abbrev :w to :up and avoid unnecessary writes
" cnoreabbrev <expr> w getcmdtype() == ':' && getcmdline() == 'w' ? 'up' : 'w'

" Easy edit / source VIMRC
nnoremap <silent> <leader>ve :e  $MYVIMRC<CR>
nnoremap <silent> <leader>vs :so $MYVIMRC<CR>
autocmd! BufWritePost,SourcePost $MYVIMRC :source $MYVIMRC |
      \ redraw | echom 'Reloaded $MYVIMRC: '
      \ . '"' . $MYVIMRC . '"'


" --- Helpers ---

" Quality-of-life solutions
augroup DaephxSolutions
  autocmd!
  " Minimal implimentations of autosave
  autocmd CursorHold,CursorHoldI * silent! update
  autocmd FocusLost * silent! wall " Write all on focus loss
augroup END
