" File: sets.vim
" Desc: Set configs for (Neo)Vim

" --- Defaults ---

" Some of these are already set by NeoVim,
" but they are here to be explicit.

set nocompatible " Don't try to be vi compatible - Nvim is always 'nocompatible'

filetype plugin indent on " allow auto-indenting depending on file type

set hidden " hide buffers instead of unloading them

" Editing
set exrc " source init file from project
set autoread " Load changes made outside of Vim
set noautochdir " Disable auto cd to open file
set clipboard=unnamed,unnamedplus " Copy paste between vim and everything else
set encoding=UTF-8 " Explicitly set file encoding
set linebreak " Split on linebreak
set formatoptions-=cro " Disable auto insert comment leader

let linelimit=102 " Set default Limit for line length
let &textwidth=linelimit " Limit length of characters in a line
let &colorcolumn=linelimit " Visually display character line limit

" Tabulation
let indent=4 " Set default indentation level
let &tabstop=indent " default length for indentation
let &softtabstop=indent
let &shiftwidth=indent " Change number of spaces for indentation
set expandtab " Convert tabs to spaces
set smartindent " Making indenting smart
set smarttab " Smarter tabbing smarter, shows 2 vs 4
set autoindent " Auto apply indentation

" Command timeout
set timeout " Set time limit on key sequence - Required for WhichKey
set lazyredraw " Execute macros faster
set timeoutlen=500 " wait for a mapped sequence to complete - Default 1000 ms
set ttimeoutlen=0 " Instant timeout for terminal buffer
set updatetime=300 " Faster completion

" Foldering
set foldmethod=indent " fold by method (indent & syntax are both good)
set foldlevelstart=9  " we want all fold to be expand at start
set foldnestmax=9     " max fold nest levels


set completeopt=menuone,noinsert,noselect
set diffopt+=vertical " Start diff mode with vertical splits
set noshowmode " no eol message



set keymodel=startsel,stopsel " Select lines w/ shift+arrow

set mouse=a " Enable mouse support

" Popup Menu
set pumheight=20 " Control popup menu length
set pumwidth=15 " Control popup menu thickness
set pumblend=10 " Control popup-menu transparency


set shortmess+=I " no intro message
set shortmess+=c " no more pattern not found
set shortmess+=f " Shorter quickfix/search count

set scrolloff=8 " Keep cursor closer to center
set noerrorbells " No more annoying bells

" set inccommand
set showtabline=2 " Always show tabline

" Spelling
set spellsuggest=fast,10

" Cursor
set ruler " Show the cursor position all the time
set virtualedit+=onemore " Allow hover end-of-line in normal
" set guicursor=a:blinkwait5-blinkon5-blinkoff5


" Display
set number " Display line numbers
set relativenumber " Show distance relative to current line
set cmdheight=1 " Make command-line only one row high
set nowrap " Display long lines as just one line
set sidescroll=1 " Smoother horizontal scrolling
set splitbelow " Horizantal splits will automatically be to the bottom
set splitright " Vertical splits will automatically be to the right
" set list " Required to show whitespaace
" set lcs+=space:· " Render whitespace as dots

" Search
set ignorecase " Case insensitive search - required for smartcase
set smartcase " Case sensitive only if search contains uppers
set incsearch " Enable incrimental search
set hlsearch " highlight search

" History
set noswapfile
" set backupdir=$MYRUNTIME/tmp/undo " Where to put backup files
set nobackup " Recommened by coc
set nowritebackup " Recommened by coc
" set undodir=$MYRUNTIME/tmp/undo " Where to put undo files
set undofile " Maintain undo history between sessions
set undolevels=1000 " Maximum number of changes that can be undone
set undoreload=10000 " Save the whole buffer for undo

" Wildmenu
set wildmenu " Enable wild menu by default
" Ignore files
set wildignore+=**/.git/* " Git Version control
set wildignore+=**/android/*
set wildignore+=**/build/* " Common build directory
set wildignore+=**/coverage/*
set wildignore+=**/ios/*
set wildignore+=**/node_modules/* " Node module environment
set wildignore+=*.pyc " Python cache
set wildignore+=*_build/*


" --- Conditionals ---

" Enable syntax highlighting
if !g:syntax_on
  set syntax=on
endif

" Always show the signcolumn, otherwise it would shift the text
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
