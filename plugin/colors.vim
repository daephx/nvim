" File: colors.vim
" Description: Initalize colorscheme for (Neo)Vim
" Author: Daephx

" --- Initialization ---

" Load colorscheme definitions
function! InitalizeColorscheme()

  colorscheme tokyonight
  set background=dark

  call EnableTransparentBackground()

  " Enable syntax highlighting
  if !exists('g:syntax_on')
    set syntax=on
  endif

  " enable support for 24-bit true color palette in colorschemes
  if has('termguicolors') && has('nvim') && $TERM != 'linux'
    set termguicolors
    set guifont=CaskaydiaCove\ NF:h16,Monaco:h16,Inconsolata-gz:16
  endif

  " Inform of proper initialization
  redraw | echom "Loaded colors: " . g:colors_name

endfunction


" Set comment lines to slanted italics
function! EnableItalicComments()

  " Color definitions
  highlight Comment      cterm=italic  gui=italic
  highlight Comment      ctermfg=none  guifg=gray

endfunction


" Clear background colors for clean transparency
function! EnableTransparentBackground()

  let g:transparency_on = 1

  " Color definitions
  hi CursorLine cterm=underline gui=none guibg=#171824

  hi clear CursorLineNr
  hi link CursorLineNr CursorLine

  highlight EndOfBuffer                guibg=none
  highlight Folded                     guibg=none
  highlight NonText      ctermbg=none  guibg=none
  highlight NonText      ctermfg=7
  highlight NonText      guifg=gray    guibg=none
  highlight Normal       ctermbg=none  guibg=none
  highlight SignColumn   ctermbg=none  guibg=none
  highlight SpecialKey   ctermbg=none  guibg=none
  highlight SpellBad     gui=underline guifg=indianred
  highlight SpellBad     cterm=underline ctermfg=red
  highlight SpellBad     guibg=none    guifg=red



  " highlight Todo         ctermbg=none  guibg=none

  " Link TODO comments to definition highlighting
  " highlight link Todo Define

  " Overwrite Diff colors
  hi DiffAdd guifg=green guibg=none
  hi DiffChanged guifg=yellow guibg=none
  hi DiffDelete guifg=red guibg=none

endfunction

" Execute color functions
call InitalizeColorscheme()

" Mapping: Quick refesh colorscheme
nnoremap <leader>lcs :call InitalizeColorscheme()<CR>

" ==============================================================================

" augroup vimrc_todo
"     au!
"     au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
"           \ containedin=.*Comment,vimCommentTitle
" augroup END
" hi def link MyTodo Todo

" FIXME: Or don't, maybe a better implimentation?
"        At the moment it's throwing a few errors.
" if has("autocmd")
"   " Highlight TODO, FIXME, NOTE, etc.
"   if v:version > 701
"     autocmd Syntax * call matchadd('Todo', '\zs\<(TODO\|FIXME\|CHANGED\|BUG\|HACK\):/')
"     autocmd Syntax * call matchadd('Debug', '\zs\<(NOTE\|INFO\|IDEA\):/')
"     highlight Todo guibg=none guifg=orange
"     highlight Debug guibg=none guifg=skyblue
"   endif
" endif


" Define custom overrides for all colorschemes
" augroup colorscheme_overrides
"   autocmd!
"   autocmd ColorScheme *
"     \   highlight Normal ctermbg=none guifg=lightgrey guibg=black
"     \ | highlight MatchParen cterm=bold ctermfg=red ctermbg=none gui=bold guifg=red guibg=none
" augroup END

" ==============================================================================

" --- Examples ---

" A few examples that often give probelms with highlighting.
" Here we can verify that everything is working as expected.

" BUG: This is a test comment
" CHANGED: This is a test comment
" FIXME: This is a test comment
" TODO: This is a test comment
" HACK: This is a test comment
" IDEA: This is a test comment
" NOTE: This is a test comment

" TODO(USER): This is a test comment
" FIXME(USER): This is a test comment
" HACK(USER): This is a test comment
" NOTE(USER): This is a test comment

" DEBUG: This is a test comment
" INFO: This is a test comment
" WARN: This is a test comment
" ERROR: This is a test comment
