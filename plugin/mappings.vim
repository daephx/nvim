" --- Mappings ---

" Keep selected test when fixing indentation
vnoremap << <gv
vnoremap >> >gv

" Escape terminal w/o annoying chord
" http://neovim.io/doc/user/nvim_terminal_emulator.html
" tnoremap <Esc> <C-\><C-n>

" Select all via Ctrl+a
" noremap <C-a> <esc>ggVG<CR>

" Quick close current buffer
nnoremap <silent> <leader>bd :bdelete<CR>

" Easy buffer switching
nnoremap <silent> <C-PageUp> :bn<CR>
nnoremap <silent> <C-PageDown> :bp<CR>

" Disable search highlight when done
" nnoremap <esc><esc> :silent! nohls<cr>
" nnoremap <esc> :silent! nohls<cr>

" Toggle, scroll offset -- vertically centered cursor
nnoremap <leader>zz :call VCenterCursor()<CR>

" Wild menu bindings
" By default, wildmenu uses left-right or tab for cycling
" in a vertical list, up/down make more sense.

" cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
" cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
" cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
" cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<ight>"

" Window resizing
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>


xnoremap <leader>p "_dP

if has('unix')
  " Make current script executable
  nnoremap <leader>x :silent !chmod +x %<CR>
endif

" --- WhichKey ---

" Configuration for Which-Key plugin

" Verify which-key exists before proceeding
if !&rtp =~ 'which-key' | finish | endif

" Alternative, plugin check
" if !exists(':which_key#start')
"   finish
" endif


" This plugin requires timeout and a recommened length not too big/small
" You should set this in your init file, If not set we will set it here | default = 1000
if !&timeout | let &timeout=1 | endif
if !&timeoutlen <= 0 | let &timeoutlen=500 | endif

if empty('g:mapleader') || empty('g:localleader')
  echoerr "WhichKey plugin requires both a <leader> and <localleader>!"
    \ . "\n Please set these in your vimrc/init.vim"
  finish
endif

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  "&localleader"<CR>
nnoremap <silent> \ :WhichKey  '\'<CR>

" Create empty map to add keys to later
let g:which_key_map =  {}

" Define a separator
let g:which_key_sep = '→'
" let g:which_key_sep = 'U\2192'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
" highlight default link WhichKey          Operator
" highlight default link WhichKeySeperator DiffAdded
" highlight default link WhichKeyGroup     Identifier
" highlight default link WhichKeyDesc      Function

" Hide status line
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" NOTE: If you wish to hide a mapping from the menu
" set it's description to 'which_key_ignore'
" Example: let g:which_key_map['_'] = { 'name': 'which_key_ignore' }

" Single mappings
let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'  , 'comment' ]
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['f'] = [ ':Files'                     , 'search files' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below']
let g:which_key_map['r'] = [ ':Ranger'                    , 'ranger' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['T'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen' ]


" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search',
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 's' : [':Snippets'     , 'snippets'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }


let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 's' : [':Git'               , 'git status'],
      \ 'r' : [':Git remote'        , 'git remote'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
