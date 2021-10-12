" File: coc.vim
" Link: https://github.com/neoclide/coc.nvim
" Description: Configuration settings for coc
" Nodejs extension host for vim & neovim,
" load extensions like VSCode and host language servers.

" --- Conquer of Completion ---

" Prevent config loading w/o plugin
if &rtp !~ 'coc.nvim'
  finish
endif

" --- Extensions ---

let g:coc_global_extensions = [
	\ 'coc-pairs',
	\ 'coc-vimtex',
  \ 'coc-css',
  \ 'coc-explorer',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-marketplace',
  \ 'coc-powershell',
  \ 'coc-prettier',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-yaml'
  \ ]


" --- Settings ---

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Recommened by coc
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to ins-completion-menu
set shortmess+=c

" Don't load the defx-git plugin file, not needed
let b:defx_git_loaded = 1


" --- Commands ---

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Prettier` to format with prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


" --- Mappings ---

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Select Word -- vscode like behavior
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunction
nmap <expr> <silent> <C-d> <SID>select_current_word()
map <expr> <silent> <C-d> <SID>select_current_word()


" --- Coc-Explorer ---

nmap <silent> <leader>e :CocCommand explorer<CR>
nmap <silent> <leader>f :CocCommand explorer --preset floating<CR>

" autocmd! BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
autocmd! FileType 'coc-explorer' setlocal winfixwidth
autocmd! FileType,BufLeave

" Change color of coc-explorer floating window
autocmd! ColorScheme *
  \   hi CocExplorerNormalFloatBorder guifg=grey guibg=grey
  \ | hi CocExplorerNormalFloat guibg=none
  \ | hi CocExplorerSelectUI guibg=blue

" Global Presets
let g:coc_explorer_global_presets = {
  \   ".vim": {
  \     'root-uri': $MYRUNTIME,
  \   },
  \   'tab': {
  \     'position': 'tab',
  \     'quit-on-open': v:true,
  \   },
  \   'floating': {
  \     'position': 'floating',
  \     'open-action-strategy': 'sourceWindow'
  \   },
  \   'floatingTop': {
  \     'position': 'floating',
  \     'floating-position': 'center-top',
  \     'open-action-strategy': 'sourceWindow',
  \   },
  \   'floatingLeftside': {
  \     'position': 'floating',
  \     'floating-position': 'left-center',
  \     'floating-width': 50,
  \     'open-action-strategy': 'sourceWindow',
  \   },
  \   'floatingRightside': {
  \     'position': 'floating',
  \     'floating-position': 'right-center',
  \     'floating-width': 50,
  \     'open-action-strategy': 'sourceWindow',
  \   },
  \   'simplify': {
  \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
  \   }
  \ }
